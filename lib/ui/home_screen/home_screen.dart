import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/data/repository/task_list_repository/i_task_list_repository.dart';
import 'package:to_do_list/ui/common/app_error_widget.dart';
import 'package:to_do_list/ui/common/utils.dart';
import 'package:to_do_list/ui/home_screen/empty_state_home.dart';
import 'package:to_do_list/ui/home_screen/task_widget_in_home_screen.dart';

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
          } else if (state is HomeScreenError) {
            return AppErrorWidget(
              exception: state.appException,
              onPressed: () {
                context.read<HomeScreenBloc>().add(HomeScreenRefresh());
              },
            );
          } else if (state is HomeScreenSuccess) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                shadowColor: Colors.transparent,
                actionsPadding: const EdgeInsets.only(right: 21),
                actions: const [Icon(Icons.search, size: 27)],
                titleSpacing: 21,
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/app_bar/app_bar_dooit_logo.png'),
                    const SizedBox(width: 12),
                    const Text('Dooit'),
                  ],
                ),
              ),
              floatingActionButton: SizedBox(
                height: 65,
                width: 65,
                child: FloatingActionButton(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: const CircleBorder(),
                  onPressed: () {},
                  child: const Icon(CupertinoIcons.plus, size: 30, grade: 10),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 41),
                  Center(
                    child: CustomSlidingSegmentedControl(
                      fixedWidth: MediaQuery.of(context).size.width / 2 - 24,
                      initialValue: state.isPinned
                          ? AllListPinnedEnum.pinned
                          : AllListPinnedEnum.allList,
                      innerPadding: EdgeInsets.zero,
                      thumbDecoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffE5E5E5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 47,
                      children: {
                        AllListPinnedEnum.allList: Text(
                          'All List',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: state.isPinned
                                ? Colors.black.withAlpha(100)
                                : Colors.white,
                          ),
                        ),
                        AllListPinnedEnum.pinned: Text(
                          'Pinned',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: state.isPinned
                                ? Colors.white
                                : Colors.black.withAlpha(100),
                          ),
                        ),
                      },
                      onValueChanged: (value) {
                        context.read<HomeScreenBloc>().add(
                          HomeScreenStarted(isPinned: !state.isPinned),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 50),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.taskLists.length,
                      itemBuilder: (context, index) {
                        final taskList = state.taskLists[index];
                        return TaskWidgetInHomeScreen(
                          taskList: taskList,
                          key: ValueKey(taskList.taskListID),
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
          } else if (state is HomeScreenEmptyState) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                shadowColor: Colors.transparent,
                actionsPadding: const EdgeInsets.only(right: 21),
                actions: const [Icon(Icons.search, size: 27)],
                titleSpacing: 21,
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/app_bar/app_bar_dooit_logo.png'),
                    const SizedBox(width: 12),
                    const Text('Dooit'),
                  ],
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 41),
                  Center(
                    child: CustomSlidingSegmentedControl(
                      fixedWidth: MediaQuery.of(context).size.width / 2 - 24,
                      initialValue: state.isPinned
                          ? AllListPinnedEnum.pinned
                          : AllListPinnedEnum.allList,
                      innerPadding: EdgeInsets.zero,
                      thumbDecoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffE5E5E5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 47,
                      children: {
                        AllListPinnedEnum.allList: Text(
                          'All List',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: state.isPinned
                                ? Colors.black.withAlpha(100)
                                : Colors.white,
                          ),
                        ),
                        AllListPinnedEnum.pinned: Text(
                          'Pinned',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: state.isPinned
                                ? Colors.white
                                : Colors.black.withAlpha(100),
                          ),
                        ),
                      },
                      onValueChanged: (value) {
                        context.read<HomeScreenBloc>().add(
                          HomeScreenStarted(isPinned: !state.isPinned),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 50),
                  Expanded(
                    child: EmptyStateWidget(
                      newListFunc: () {},
                      isPinned: state.isPinned,
                    ),
                  ),
                ],
              ),
            );
          } else {
            throw Exception('State is not supported');
          }
        },
      ),
    );
  }
}
