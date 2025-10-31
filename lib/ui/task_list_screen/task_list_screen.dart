import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/data/repository/task_list_repository/i_task_list_repository.dart';
import 'package:to_do_list/ui/common/app_error_widget.dart';

import 'task_list_screen_bloc/task_list_screen_bloc.dart';

class TaskListScreen extends StatelessWidget {
  final String taskListID;
  final bool? isNewTaskList;

  const TaskListScreen({
    super.key,
    required this.taskListID,
    this.isNewTaskList = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final taskListScreenBloc = TaskListScreenBloc(
          taskListRepository: taskListRepository,
        );
        taskListScreenBloc.add(
          TaskListScreenStarted(
            taskListID: taskListID,
            isNewTaskList: isNewTaskList,
          ),
        );
        return taskListScreenBloc;
      },
      child: BlocBuilder<TaskListScreenBloc, TaskListScreenState>(
        builder: (context, state) {
          if (state is TaskListScreenLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskListScreenSuccess) {
            final taskList = state.taskList;
            final isEditingTaskTitle = taskList.taskListID == state.editingID;
            final isAddingTask = state.isAddingTask;
            String addNewTaskTitle = '';
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (isEditingTaskTitle) {
                  context.read<TaskListScreenBloc>().add(
                    TaskListScreenEditTaskListTitleSaved(
                      taskListID: taskListID,
                      taskListNewTitle: state.editingTitle!.trim(),
                    ),
                  );
                } else if (state.editingID != null &&
                    state.editingTitle != null) {
                  context.read<TaskListScreenBloc>().add(
                    TaskListScreenEditTaskTitleSaved(
                      taskListID: taskListID,
                      taskItemID: state.editingID!,
                      taskItemNewTitle: state.editingTitle!.trim(),
                    ),
                  );
                } else if (isAddingTask) {
                  context.read<TaskListScreenBloc>().add(
                    TaskListScreenStartAddTaskSubmitted(
                      taskListID: taskListID,
                      newTaskItemTitle: addNewTaskTitle,
                    ),
                  );
                }
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  surfaceTintColor: Colors.white,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  actionsPadding: const EdgeInsets.only(right: 24),

                  centerTitle: true,
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        context.read<TaskListScreenBloc>().add(
                          TaskListScreenTaskListTogglePin(
                            taskListID: taskListID,
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.resolveWith<Color?>((
                              Set<WidgetState> states,
                            ) {
                              if (taskList.taskListPinned) {
                                return Colors.black;
                              }
                              return Colors.white;
                            }),
                        foregroundColor:
                            WidgetStateProperty.resolveWith<Color?>((
                              Set<WidgetState> states,
                            ) {
                              if (taskList.taskListPinned) {
                                return Colors.white;
                              }
                              return Colors.black;
                            }),
                        shape: const WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            side: BorderSide(width: 2, color: Colors.black),
                          ),
                        ),
                        padding: const WidgetStatePropertyAll(
                          EdgeInsets.fromLTRB(8, 7, 8, 7),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(CupertinoIcons.map_pin),
                          Text(taskList.taskListPinned ? 'Pinned' : 'Pin'),
                        ],
                      ),
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isEditingTaskTitle
                          ? TextField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                              autofocus: isEditingTaskTitle,
                              controller: TextEditingController.fromValue(
                                TextEditingValue(
                                  text: state.editingTitle ?? '',
                                  selection: TextSelection.collapsed(
                                    offset: state.editingTitle?.length ?? 0,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                context.read<TaskListScreenBloc>().add(
                                  TaskListScreenEditTaskListTitleChanged(
                                    taskListID: taskListID,
                                    newTaskListTitle: value,
                                  ),
                                );
                              },
                              onSubmitted: (value) {
                                context.read<TaskListScreenBloc>().add(
                                  TaskListScreenEditTaskListTitleSaved(
                                    taskListID: taskListID,
                                    taskListNewTitle: value.trim(),
                                  ),
                                );
                              },
                            )
                          : GestureDetector(
                              onTap: () {
                                context.read<TaskListScreenBloc>().add(
                                  TaskTaskScreenStartEditTaskList(
                                    taskListID: taskListID,
                                  ),
                                );
                              },
                              child: Text(
                                taskList.taskListTitle,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: taskList.taskListItems.length + 1,
                          itemBuilder: (context, index) {
                            if (index == taskList.taskListItems.length) {
                              return isAddingTask
                                  ? TextField(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        isDense: true,
                                      ),

                                      autofocus: isAddingTask,
                                      controller:
                                          TextEditingController.fromValue(
                                            TextEditingValue(
                                              text: state.editingTitle ?? '',
                                              selection:
                                                  TextSelection.collapsed(
                                                    offset:
                                                        state
                                                            .editingTitle
                                                            ?.length ??
                                                        0,
                                                  ),
                                            ),
                                          ),
                                      onChanged: (value) {
                                        addNewTaskTitle = value;
                                      },
                                      onSubmitted: (value) {
                                        addNewTaskTitle = value;
                                        context.read<TaskListScreenBloc>().add(
                                          TaskListScreenStartAddTaskSubmitted(
                                            taskListID: taskListID,
                                            newTaskItemTitle: addNewTaskTitle,
                                          ),
                                        );
                                      },
                                    )
                                  : ListTile(
                                      key: const ValueKey('add_task_button'),
                                      contentPadding: const EdgeInsets.only(
                                        left: 0,
                                        right: 0,
                                      ),
                                      leading: const Icon(
                                        Icons.add_box_outlined,
                                      ),
                                      title: const Text('Add new task'),
                                      onTap: () {
                                        context
                                            .read<TaskListScreenBloc>()
                                            .add(
                                              TaskListScreenStartAddTask(
                                                taskListID: taskListID,
                                              ),
                                            );
                                      },
                                    );
                            }
                            final taskItem = taskList.taskListItems[index];
                            final isEditing =
                                taskItem.taskItemID == state.editingID;
                            return ListTile(
                              key: ValueKey(taskItem.taskItemID),
                              contentPadding: const EdgeInsets.only(
                                left: 0,
                                right: 0,
                              ),
                              leading: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.drag_indicator),
                                  GestureDetector(
                                    onTap: () {
                                      context.read<TaskListScreenBloc>().add(
                                        TaskListScreenToggleTaskCompletion(
                                          taskListID: taskListID,
                                          taskItemID: taskItem.taskItemID,
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      !taskItem.taskItemIsCompleted
                                          ? Icons.check_box_outline_blank
                                          : Icons.check_box,
                                    ),
                                  ),
                                ],
                              ),
                              title: isEditing
                                  ? TextField(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        isDense: true,
                                      ),

                                      autofocus: isEditing,
                                      controller:
                                          TextEditingController.fromValue(
                                            TextEditingValue(
                                              text: state.editingTitle ?? '',
                                              selection:
                                                  TextSelection.collapsed(
                                                    offset:
                                                        state
                                                            .editingTitle
                                                            ?.length ??
                                                        0,
                                                  ),
                                            ),
                                          ),
                                      onChanged: (value) {
                                        context.read<TaskListScreenBloc>().add(
                                          TaskListScreenEditTaskTitleChanged(
                                            taskListID: taskListID,
                                            taskItemID: taskItem.taskItemID,
                                            newTaskItemTitle: value,
                                          ),
                                        );
                                      },
                                      onSubmitted: (value) {
                                        context.read<TaskListScreenBloc>().add(
                                          TaskListScreenEditTaskTitleSaved(
                                            taskListID: taskListID,
                                            taskItemID: taskItem.taskItemID,
                                            taskItemNewTitle: value.trim(),
                                          ),
                                        );
                                      },
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        context
                                            .read<TaskListScreenBloc>()
                                            .add(
                                              TaskTaskScreenStartEditTask(
                                                taskListID: taskListID,
                                                taskItemID: taskItem.taskItemID,
                                              ),
                                            );
                                      },
                                      child: Text(
                                        taskItem.taskItemTitle,
                                        style: TextStyle(
                                          decoration:
                                              taskItem.taskItemIsCompleted
                                              ? TextDecoration.lineThrough
                                              : null,
                                        ),
                                      ),
                                    ),
                              trailing: GestureDetector(
                                onTap: () {
                                  context.read<TaskListScreenBloc>().add(
                                    TaskListScreenDeleteTaskItem(
                                      taskListID: taskListID,
                                      taskItemID: taskItem.taskItemID,
                                    ),
                                  );
                                },
                                child: const Icon(Icons.delete),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is TaskListScreenError) {
            return AppErrorWidget(
              exception: state.appException,
              onPressed: () {},
            );
          } else {
            throw Exception();
          }
        },
      ),
    );
  }
}
