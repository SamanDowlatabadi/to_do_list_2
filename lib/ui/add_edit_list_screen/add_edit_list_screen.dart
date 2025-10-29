import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/data/repository/task_list_repository/i_task_list_repository.dart';
import 'package:to_do_list/ui/add_edit_list_screen/add_edit_list_screen_bloc/add_edit_list_screen_bloc.dart';
import 'package:to_do_list/ui/common/app_error_widget.dart';

class AddEditListScreen extends StatelessWidget {
  final String taskListID;

  const AddEditListScreen({super.key, required this.taskListID});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final addEditListScreenBloc = AddEditListScreenBloc(
          taskListRepository: taskListRepository,
        );
        addEditListScreenBloc.add(
          AddEditListScreenStarted(taskListID: taskListID),
        );
        return addEditListScreenBloc;
      },
      child: BlocBuilder<AddEditListScreenBloc, AddEditListScreenState>(
        builder: (context, state) {
          if (state is AddEditListScreenLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AddEditListScreenSuccess) {
            final taskList = state.taskList;
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                surfaceTintColor: Colors.white,
                backgroundColor: Colors.white,
                elevation: 0,
                shadowColor: Colors.transparent,
                actionsPadding: const EdgeInsets.only(right: 24),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<AddEditListScreenBloc>().add(
                        AddEditListScreenTaskListTogglePin(
                          taskListID: taskListID,
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color?>((
                        Set<WidgetState> states,
                      ) {
                        if (taskList.taskListPinned) {
                          return Colors.black;
                        }
                        return Colors.white;
                      }),
                      foregroundColor: WidgetStateProperty.resolveWith<Color?>((
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
                    Text(
                      taskList.taskListTitle,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: taskList.taskListItems.length + 1,
                        itemBuilder: (context, index) {
                          if (index == taskList.taskListItems.length) {
                            return ListTile(
                              key: const ValueKey('add_task'),
                              contentPadding: const EdgeInsets.only(
                                left: 0,
                                right: 0,
                              ),
                              leading: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.add, color: Colors.transparent),
                                  Icon(Icons.add_box_outlined),
                                ],
                              ),
                              title: const Text('To-do'),
                              onTap: () {},
                            );
                          }
                          final task = taskList.taskListItems[index];
                          return ListTile(
                            key: ValueKey(task.taskItemID),
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
                                    context.read<AddEditListScreenBloc>().add(
                                      AddEditListScreenToggleTaskCompletion(
                                        taskListID: taskListID,
                                        taskItemID: task.taskItemID,
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    !task.taskItemIsCompleted
                                        ? Icons.check_box_outline_blank
                                        : Icons.check_box,
                                  ),
                                ),
                              ],
                            ),
                            title: Text(
                              task.taskItemTitle,
                              style: TextStyle(
                                decoration: task.taskItemIsCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            trailing: GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.delete),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is AddEditListScreenError) {
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
