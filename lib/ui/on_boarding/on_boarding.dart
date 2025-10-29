import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/data/repository/task_list_repository/task_list_repository.dart';
import 'package:to_do_list/data/source/task_list_data_source/task_list_hive_data_source/task_list_hive_data_source.dart';
import 'package:to_do_list/data/task_item_module.dart';
import 'package:to_do_list/data/task_list_label.dart';
import 'package:to_do_list/data/task_list_module.dart';
import 'package:to_do_list/ui/home_screen/home_screen.dart';
import 'package:to_do_list/ui/on_boarding/on_boarding_bloc/on_boarding_bloc.dart';

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
      TaskList(
        taskListTitle: 'Shopping List',
        taskListIsExpanded: false,
        taskListPinned: false,
        taskListItems: [
          TaskItem(taskItemTitle: 'Milk', taskItemIsCompleted: true),
          TaskItem(taskItemTitle: 'Eggs', taskItemIsCompleted: false),
          TaskItem(taskItemTitle: 'Bread', taskItemIsCompleted: false),
          TaskItem(taskItemTitle: 'Fruits', taskItemIsCompleted: true),
        ],
        taskListLabel: TaskListLabel.other,
      ),
      TaskList(
        taskListTitle: 'University',
        taskListIsExpanded: false,
        taskListPinned: false,
        taskListItems: [
          TaskItem(
            taskItemTitle: 'Submit assignment',
            taskItemIsCompleted: false,
          ),
          TaskItem(
            taskItemTitle: 'Prepare for exam',
            taskItemIsCompleted: false,
          ),
          TaskItem(
            taskItemTitle: 'Check project group chat',
            taskItemIsCompleted: true,
          ),
        ],
        taskListLabel: TaskListLabel.personal,
      ),
      TaskList(
        taskListTitle: 'Fitness Goals',
        taskListIsExpanded: false,
        taskListPinned: false,
        taskListItems: [
          TaskItem(taskItemTitle: 'Run 5km', taskItemIsCompleted: false),
          TaskItem(
            taskItemTitle: 'Drink 2L of water',
            taskItemIsCompleted: true,
          ),
          TaskItem(taskItemTitle: 'Track calories', taskItemIsCompleted: false),
        ],
        taskListLabel: TaskListLabel.personal,
      ),
      TaskList(
        taskListTitle: 'Finance',
        taskListIsExpanded: false,
        taskListPinned: false,
        taskListItems: [
          TaskItem(taskItemTitle: 'Pay bills', taskItemIsCompleted: false),
          TaskItem(
            taskItemTitle: 'Update budget sheet',
            taskItemIsCompleted: true,
          ),
          TaskItem(
            taskItemTitle: 'Check investments',
            taskItemIsCompleted: false,
          ),
        ],
        taskListLabel: TaskListLabel.finance,
      ),
      TaskList(
        taskListTitle: 'Travel Plans',
        taskListIsExpanded: false,
        taskListPinned: false,
        taskListItems: [
          TaskItem(taskItemTitle: 'Book hotel', taskItemIsCompleted: true),
          TaskItem(
            taskItemTitle: 'Buy flight tickets',
            taskItemIsCompleted: true,
          ),
          TaskItem(taskItemTitle: 'Pack luggage', taskItemIsCompleted: false),
        ],
        taskListLabel: TaskListLabel.other,
      ),
      TaskList(
        taskListTitle: 'Health',
        taskListIsExpanded: false,
        taskListPinned: false,
        taskListItems: [
          TaskItem(
            taskItemTitle: 'Doctor appointment',
            taskItemIsCompleted: false,
          ),
          TaskItem(taskItemTitle: 'Take vitamins', taskItemIsCompleted: true),
          TaskItem(
            taskItemTitle: 'Meditate 15 mins',
            taskItemIsCompleted: false,
          ),
        ],
        taskListLabel: TaskListLabel.personal,
      ),
      TaskList(
        taskListTitle: 'Miscellaneous',
        taskListIsExpanded: false,
        taskListPinned: false,
        taskListItems: [
          TaskItem(
            taskItemTitle: 'Clean workspace',
            taskItemIsCompleted: false,
          ),
          TaskItem(taskItemTitle: 'Organize files', taskItemIsCompleted: true),
          TaskItem(taskItemTitle: 'Backup phone', taskItemIsCompleted: false),
        ],
        taskListLabel: TaskListLabel.other,
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
      create: (context) => OnBoardingBloc()..add(OnBoardingIsFirstLaunch()),
      child: BlocBuilder<OnBoardingBloc, OnBoardingState>(
        builder: (context, state) {
          if (state is OnBoardingInitial) {
            return const SizedBox.shrink();
          } else if (state is OnBoardingNotShow) {
            return const HomeScreen();
          } else if (state is OnBoardingShow) {
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
                  context.read<OnBoardingBloc>().add(
                    OnBoardingCompleteButtonClicked(),
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
                      'assets/images/on_boarding/on_boarding_img.png',
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
