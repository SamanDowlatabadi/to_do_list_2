import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/data/repository/task_list_repository/task_list_repository.dart';
import 'package:to_do_list/data/source/task_list_data_source/task_list_hive_data_source/task_list_hive_data_source.dart';
import 'package:to_do_list/data/task_item_module.dart';
import 'package:to_do_list/data/task_list_label.dart';
import 'package:to_do_list/data/task_list_module.dart';
import 'package:to_do_list/ui/home_screen/home_screen.dart';
import 'package:to_do_list/ui/on_boarding_screen/on_boarding_screen_bloc/on_boarding_screen_bloc.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    super.initState();
    _initializeSampleData();
  }

  Future<void> _initializeSampleData() async {
    final repository = TaskListRepository(
      taskListDataSource: TaskListHiveDataSource(),
    );
    final sampleTaskLists = [
      TaskList(
        taskListTitle: 'Personal Tasks',
        taskListIsExpanded: false,
        taskListPinned: true,
        taskListItems: [
          TaskItem(taskItemTitle: 'Morning workout', taskItemIsCompleted: true),
          TaskItem(taskItemTitle: 'Read a book', taskItemIsCompleted: false),
          TaskItem(taskItemTitle: 'Call family', taskItemIsCompleted: false),
        ],
        taskListLabel: TaskListLabel.personal,
      ),
      TaskList(
        taskListTitle: 'Work',
        taskListIsExpanded: false,
        taskListPinned: true,
        taskListItems: [
          TaskItem(
            taskItemTitle: 'Meeting with manager',
            taskItemIsCompleted: false,
          ),
          TaskItem(
            taskItemTitle: 'Plan new sprint',
            taskItemIsCompleted: false,
          ),
          TaskItem(
            taskItemTitle: 'Send client email',
            taskItemIsCompleted: true,
          ),
        ],
        taskListLabel: TaskListLabel.work,
      ),
      TaskList(
        taskListTitle: 'Flutter Project',
        taskListIsExpanded: false,
        taskListPinned: false,
        taskListItems: [
          TaskItem(taskItemTitle: 'Implement BLoC', taskItemIsCompleted: true),
          TaskItem(
            taskItemTitle: 'Design Home Screen UI',
            taskItemIsCompleted: false,
          ),
          TaskItem(
            taskItemTitle: 'Write unit tests',
            taskItemIsCompleted: false,
          ),
        ],
        taskListLabel: TaskListLabel.work,
      ),
    ];
    final f = await repository.getAllTaskLists(false);
    if (f.isEmpty) {
      await repository.saveAllTaskLists(sampleTaskLists);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OnBoardingScreenBloc()..add(OnBoardingScreenIsFirstLaunch()),
      child: BlocBuilder<OnBoardingScreenBloc, OnBoardingScreenState>(
        builder: (context, state) {
          if (state is OnBoardingScreenInitial) {
            return const SizedBox.shrink();
          } else if (state is OnBoardingScreenNotShow) {
            return const HomeScreen();
          } else if (state is OnBoardingScreenShow) {
            return Scaffold(
              backgroundColor: Colors.black,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton.extended(
                backgroundColor: Colors.white,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                onPressed: () {
                  context.read<OnBoardingScreenBloc>().add(
                    OnBoardingScreenCompleteButtonClicked(),
                  );
                },
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 88),
                  child: Text(
                    'Continue',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/on_boarding_screen/on_boarding_img.png',
                      height: 68,
                    ),
                    const SizedBox(height: 42),
                    Text(
                      'Dooit',
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 40,
                          ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'Write what you need to do. Everyday.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffC4C4C4),
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
