// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:to_do_list/common/exception.dart';
import 'package:to_do_list/data/repository/task_list_repository/i_task_list_repository.dart';
import 'package:to_do_list/data/task_item_module.dart';
import 'package:to_do_list/data/task_list_module.dart';

part 'add_edit_list_screen_event.dart';

part 'add_edit_list_screen_state.dart';

class AddEditListScreenBloc
    extends Bloc<AddEditListScreenEvent, AddEditListScreenState> {
  final ITaskListRepository taskListRepository;

  AddEditListScreenBloc({required this.taskListRepository})
    : super(AddEditListScreenLoading()) {
    on<AddEditListScreenEvent>((event, emit) async {
      if (event is AddEditListScreenStarted) {
        try {
          if(event.isNewTaskList!){
            await taskListRepository.addTaskList(event.taskListID);
          }
          final taskList = await taskListRepository.getTaskList(
            event.taskListID,
          );
          emit(AddEditListScreenSuccess(taskList: taskList));
        } catch (e) {
          emit(
            AddEditListScreenError(
              appException: e is AppException ? e : AppException(),
            ),
          );
        }
      } else if (event is AddEditListScreenTaskListTogglePin) {
        try {
          await taskListRepository.togglePinTaskList(event.taskListID);
          final taskList = await taskListRepository.getTaskList(
            event.taskListID,
          );
          emit(
            AddEditListScreenSuccess(
              taskList: taskList,
              editingID: null,
              editingTitle: null,
            ),
          );
        } catch (e) {
          emit(
            AddEditListScreenError(
              appException: e is AppException ? e : AppException(),
            ),
          );
        }
      } else if (event is AddEditListScreenToggleTaskCompletion) {
        try {
          await taskListRepository.toggleTaskCompletion(
            event.taskListID,
            event.taskItemID,
          );
          final taskList = await taskListRepository.getTaskList(
            event.taskListID,
          );
          emit(AddEditListScreenSuccess(taskList: taskList));
        } catch (e) {
          emit(
            AddEditListScreenError(
              appException: e is AppException ? e : AppException(),
            ),
          );
        }
      } else if (event is AddEditTaskScreenStartEditTask) {
        try {
          final taskItem = await taskListRepository.getTaskItem(
            event.taskListID,
            event.taskItemID,
          );
          emit(
            AddEditListScreenSuccess(
              taskList: (state as AddEditListScreenSuccess).taskList,
              editingID: taskItem.taskItemID,
              editingTitle: taskItem.taskItemTitle,
            ),
          );
        } catch (e) {
          emit(
            AddEditListScreenError(
              appException: e is AppException ? e : AppException(),
            ),
          );
        }
      } else if (event is AddEditListScreenEditTaskTitleChanged) {
        try {
          emit(
            AddEditListScreenSuccess(
              taskList: (state as AddEditListScreenSuccess).taskList,
              editingID: (state as AddEditListScreenSuccess).editingID,
              editingTitle: event.newTaskItemTitle,
            ),
          );
        } catch (e) {
          emit(
            AddEditListScreenError(
              appException: e is AppException ? e : AppException(),
            ),
          );
        }
      } else if (event is AddEditListScreenEditTaskTitleSaved) {
        try {
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
          final taskList = await taskListRepository.getTaskList(
            event.taskListID,
          );
          emit(AddEditListScreenSuccess(taskList: taskList));
        } catch (e) {
          emit(
            AddEditListScreenError(
              appException: e is AppException ? e : AppException(),
            ),
          );
        }
      }
      //////////////////////////////////////////////////////////////////////////
      else if (event is AddEditTaskScreenStartEditTaskList) {
        try {
          final taskList = await taskListRepository.getTaskList(
            event.taskListID,
          );
          emit(
            AddEditListScreenSuccess(
              taskList: (state as AddEditListScreenSuccess).taskList,
              editingID: taskList.taskListID,
              editingTitle: taskList.taskListTitle,
            ),
          );
        } catch (e) {
          emit(
            AddEditListScreenError(
              appException: e is AppException ? e : AppException(),
            ),
          );
        }
      } else if (event is AddEditListScreenEditTaskListTitleChanged) {
        try {
          emit(
            AddEditListScreenSuccess(
              taskList: (state as AddEditListScreenSuccess).taskList,
              editingID: (state as AddEditListScreenSuccess).editingID,
              editingTitle: event.newTaskListTitle,
            ),
          );
        } catch (e) {
          emit(
            AddEditListScreenError(
              appException: e is AppException ? e : AppException(),
            ),
          );
        }
      } else if (event is AddEditListScreenEditTaskListTitleSaved) {
        try {
          if (event.taskListNewTitle.trim().isNotEmpty) {
            await taskListRepository.editTaskListTitle(
              event.taskListID,
              event.taskListNewTitle.trim(),
            );
          }
          final taskList = await taskListRepository.getTaskList(
            event.taskListID,
          );
          emit(AddEditListScreenSuccess(taskList: taskList));
        } catch (e) {
          emit(
            AddEditListScreenError(
              appException: e is AppException ? e : AppException(),
            ),
          );
        }
      } else if (event is AddEditListScreenDeleteTaskItem) {
        try {
          await taskListRepository.deleteTaskItem(
            event.taskListID,
            event.taskItemID,
          );
          final taskList = await taskListRepository.getTaskList(
            event.taskListID,
          );
          emit(AddEditListScreenSuccess(taskList: taskList));
        } catch (e) {
          emit(
            AddEditListScreenError(
              appException: e is AppException ? e : AppException(),
            ),
          );
        }
      } else if (event is AddEditListScreenStartAddTask) {
        try {
          final taskList = await taskListRepository.getTaskList(
            event.taskListID,
          );
          emit(
            AddEditListScreenSuccess(taskList: taskList, isAddingTask: true),
          );
        } catch (e) {
          emit(
            AddEditListScreenError(
              appException: e is AppException ? e : AppException(),
            ),
          );
        }
      } else if (event is AddEditListScreenStartAddTaskSubmitted) {
        try {
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
            AddEditListScreenSuccess(taskList: taskList, isAddingTask: false),
          );
        } catch (e) {
          emit(
            AddEditListScreenError(
              appException: e is AppException ? e : AppException(),
            ),
          );
        }
      } else if (event is AddEditListScreenDeleteTaskList) {
        try {
          await taskListRepository.deleteTaskList(event.taskListID);
        } catch (e) {
          emit(
            AddEditListScreenError(
              appException: e is AppException ? e : AppException(),
            ),
          );
        }
      }
    });
  }
}
