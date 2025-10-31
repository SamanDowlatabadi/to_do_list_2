import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/data/repository/task_list_repository/i_task_list_repository.dart';
import 'package:to_do_list/data/task_list_module.dart';
import 'package:to_do_list/ui/common/app_error_widget.dart';
import 'package:to_do_list/ui/common/home_screen_app_bar.dart';
import 'package:to_do_list/ui/common/home_screen_slider.dart';
import 'package:to_do_list/ui/common/empty_state_home.dart';
import 'package:to_do_list/ui/common/task_widget_in_home_screen.dart';
import 'package:to_do_list/ui/task_list_screen/task_list_screen.dart';
import 'home_screen_bloc/home_screen_bloc.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeScreenBloc = HomeScreenBloc(
          taskListRepository: taskListRepository,
        );
        homeScreenBloc.add(HomeScreenStarted(isPinned: false));
        return homeScreenBloc;
      },
      child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          if (state is HomeScreenLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is HomeScreenError) {
            return AppErrorWidget(
              exception: state.appException,
              onPressed: () {
                context.read<HomeScreenBloc>().add(HomeScreenRefresh());
              },
            );
          }
          else if (state is HomeScreenSuccess) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: homeScreenAppBar(context),
              floatingActionButton: SizedBox(
                height: 65,
                width: 65,
                child: FloatingActionButton(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: const CircleBorder(),
                  onPressed: () {
                    final sample = sampleTaskList();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>TaskListScreen(
                          taskListID: sample.taskListID,
                          isNewTaskList: true,
                        ),
                      ),
                    );
                  },
                  child: const Icon(CupertinoIcons.plus, size: 30, grade: 10),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HomeScreenSlider(isPinned: state.isPinned,),
                  const SizedBox(height: 50),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.taskLists.length,
                      itemBuilder: (context, index) {
                        final taskList = state.taskLists[index];
                        return TaskWidgetInHomeScreen(
                          taskList: taskList,
                          key: ValueKey(taskList.taskListID),
                          deleteTaskList: () =>
                              context.read<HomeScreenBloc>().add(
                                HomeScreenDeleteTaskList(
                                  taskListID: taskList.taskListID,
                                ),
                              ),

                          toggleTaskListExpansion: () =>
                              context.read<HomeScreenBloc>().add(
                                HomeScreenToggleTaskListExpanded(
                                  taskListID: taskList.taskListID,
                                ),
                              ),
                          toggleTaskItemCompletion: (taskItemID) {
                            context.read<HomeScreenBloc>().add(
                              HomeScreenToggleTaskCompletion(
                                taskListID: taskList.taskListID,
                                taskItemID: taskItemID,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          else if (state is HomeScreenEmptyState) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: homeScreenAppBar(context),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HomeScreenSlider(isPinned: state.isPinned,),
                  const SizedBox(height: 50),
                  Expanded(
                    child: EmptyStateWidget(
                      isPinned: state.isPinned,
                      newListFunc: () {
                        final sample = sampleTaskList();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TaskListScreen(
                              taskListID: sample.taskListID,
                              isNewTaskList: true,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          else {
            throw Exception('State is not supported');
          }
        },
      ),
    );
  }
}