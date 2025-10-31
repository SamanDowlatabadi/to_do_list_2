// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:to_do_list/common/exception.dart';
import 'package:to_do_list/data/repository/task_list_repository/i_task_list_repository.dart';
import 'package:to_do_list/data/task_item_module.dart';
import 'package:to_do_list/data/task_list_module.dart';

part 'task_list_screen_event.dart';

part 'task_list_screen_state.dart';

class TaskListScreenBloc
    extends Bloc<TaskListScreenEvent, TaskListScreenState> {
  final ITaskListRepository taskListRepository;
  late final VoidCallback _onChangedRepository;

  TaskListScreenBloc({required this.taskListRepository})
    : super(TaskListScreenLoading()) {
    _onChangedRepository = () {
      if(state is TaskListScreenSuccess){
        add(
          TaskListScreenStarted(
            taskListID: (state as TaskListScreenSuccess).taskList.taskListID,
          ),
        );
      }
    };
    ITaskListRepository.taskListNotifier.addListener(_onChangedRepository);

    on<TaskListScreenEvent>((event, emit) async {
      try {
        if (event is TaskListScreenStarted) {
          if (event.isNewTaskList!) {
            await taskListRepository.addTaskList(event.taskListID);
          }
          final taskList = await taskListRepository.getTaskList(
            event.taskListID,
          );
          emit(TaskListScreenSuccess(taskList: taskList));
        } else if (event is TaskListScreenTaskListTogglePin) {
          await taskListRepository.togglePinTaskList(event.taskListID);

        } else if (event is TaskListScreenToggleTaskCompletion) {
          await taskListRepository.toggleTaskCompletion(
            event.taskListID,
            event.taskItemID,
          );
        } else if (event is TaskTaskScreenStartEditTask) {
          final taskItem = await taskListRepository.getTaskItem(
            event.taskListID,
            event.taskItemID,
          );
          emit(
            TaskListScreenSuccess(
              taskList: (state as TaskListScreenSuccess).taskList,
              editingID: taskItem.taskItemID,
              editingTitle: taskItem.taskItemTitle,
            ),
          );
        } else if (event is TaskListScreenEditTaskTitleChanged) {
          emit(
            TaskListScreenSuccess(
              taskList: (state as TaskListScreenSuccess).taskList,
              editingID: (state as TaskListScreenSuccess).editingID,
              editingTitle: event.newTaskItemTitle,
            ),
          );
        } else if (event is TaskListScreenEditTaskTitleSaved) {
          if (event.taskItemNewTitle.trim().isNotEmpty) {
            await taskListRepository.editTaskItemTitle(
              event.taskListID,
              event.taskItemID,
              event.taskItemNewTitle.trim(),
            );
          }
          final TaskItem taskItem = await taskListRepository.getTaskItem(
            event.taskListID,
            event.taskItemID,
          );
          if (taskItem.taskItemIsCompleted) {
            await taskListRepository.toggleTaskCompletion(
              event.taskListID,
              event.taskItemID,
            );
          }

        }
        //////////////////////////////////////////////////////////////////////////
        else if (event is TaskTaskScreenStartEditTaskList) {
          final taskList = await taskListRepository.getTaskList(
            event.taskListID,
          );
          emit(
            TaskListScreenSuccess(
              taskList: (state as TaskListScreenSuccess).taskList,
              editingID: taskList.taskListID,
              editingTitle: taskList.taskListTitle,
            ),
          );
        } else if (event is TaskListScreenEditTaskListTitleChanged) {
          emit(
            TaskListScreenSuccess(
              taskList: (state as TaskListScreenSuccess).taskList,
              editingID: (state as TaskListScreenSuccess).editingID,
              editingTitle: event.newTaskListTitle,
            ),
          );
        } else if (event is TaskListScreenEditTaskListTitleSaved) {
          if (event.taskListNewTitle.trim().isNotEmpty) {
            await taskListRepository.editTaskListTitle(
              event.taskListID,
              event.taskListNewTitle.trim(),
            );
          }

        } else if (event is TaskListScreenDeleteTaskItem) {
          await taskListRepository.deleteTaskItem(
            event.taskListID,
            event.taskItemID,
          );

        } else if (event is TaskListScreenStartAddTask) {

          emit(
            TaskListScreenSuccess(taskList: (state as TaskListScreenSuccess).taskList, isAddingTask: true),
          );
        } else if (event is TaskListScreenStartAddTaskSubmitted) {
          if (event.newTaskItemTitle.trim().isNotEmpty) {
            await taskListRepository.addTaskItemToTaskList(
              event.taskListID,
              event.newTaskItemTitle.trim(),
            );
          }
          final taskList = await taskListRepository.getTaskList(
            event.taskListID,
          );
          emit(
            TaskListScreenSuccess(taskList: taskList, isAddingTask: false),
          );
        } else if (event is TaskListScreenDeleteTaskList) {
          await taskListRepository.deleteTaskList(event.taskListID);
        }
      } catch (e) {
        emit(
          TaskListScreenError(
            appException: e is AppException ? e : AppException(),
          ),
        );
      }
    });
  }

  @override
  Future<void> close() {
    ITaskListRepository.taskListNotifier.removeListener(_onChangedRepository);
    return super.close();
  }
}
