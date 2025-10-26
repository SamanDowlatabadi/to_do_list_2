import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_list/data/repository/task_list_repository/task_list_repository.dart';
import 'package:to_do_list/data/source/task_list_data_source/task_list_file_data_source/task_list_file_data_source.dart';
import 'package:to_do_list/data/source/task_list_data_source/task_list_hive_data_source/module/task_item_hive_module.dart';
import 'package:to_do_list/data/source/task_list_data_source/task_list_hive_data_source/module/task_list_hive_module.dart';
import 'package:to_do_list/data/source/task_list_data_source/task_list_hive_data_source/task_list_hive_data_source.dart';
import 'package:to_do_list/data/task_item_module.dart';
import 'package:to_do_list/data/task_list_label.dart';
import 'package:to_do_list/ui/on_boarding/on_boarding.dart';

import 'data/task_list_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskListHiveModuleAdapter());
  Hive.registerAdapter(TaskItemHiveModuleAdapter());
  Hive.registerAdapter(TaskListLabelAdapter());
  await Hive.openBox<TaskListHiveModule>(TaskListHiveDataSource.boxName);

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
        TaskItem(taskItemTitle: 'Plan new sprint', taskItemIsCompleted: false),
        TaskItem(taskItemTitle: 'Send client email', taskItemIsCompleted: true),
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
        TaskItem(taskItemTitle: 'Write unit tests', taskItemIsCompleted: false),
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
        TaskItem(taskItemTitle: 'Prepare for exam', taskItemIsCompleted: false),
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
        TaskItem(taskItemTitle: 'Drink 2L of water', taskItemIsCompleted: true),
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
        TaskItem(taskItemTitle: 'Meditate 15 mins', taskItemIsCompleted: false),
      ],
      taskListLabel: TaskListLabel.personal,
    ),
    TaskList(
      taskListTitle: 'Miscellaneous',
      taskListIsExpanded: false,
      taskListPinned: false,
      taskListItems: [
        TaskItem(taskItemTitle: 'Clean workspace', taskItemIsCompleted: false),
        TaskItem(taskItemTitle: 'Organize files', taskItemIsCompleted: true),
        TaskItem(taskItemTitle: 'Backup phone', taskItemIsCompleted: false),
      ],
      taskListLabel: TaskListLabel.other,
    ),
  ];

  await repository.saveAllTaskLists(sampleTaskLists);

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final String fontFamily = 'graphik';
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: fontFamily,
        textTheme: TextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: OnBoardingScreen(),
    );
  }
}
