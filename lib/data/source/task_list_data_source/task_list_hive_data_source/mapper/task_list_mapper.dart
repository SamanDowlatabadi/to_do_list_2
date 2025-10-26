import 'package:to_do_list/data/source/task_list_data_source/task_list_hive_data_source/module/task_item_hive_module.dart';
import 'package:to_do_list/data/source/task_list_data_source/task_list_hive_data_source/module/task_list_hive_module.dart';
import 'package:to_do_list/data/task_item_module.dart';
import 'package:to_do_list/data/task_list_module.dart';

extension TaskListToHive on TaskList {
  TaskListHiveModule toHive() {
    return TaskListHiveModule(
      taskListTitle: taskListTitle,
      taskListPinned: taskListPinned,
      taskListItems: taskListItems
          .map(
            (taskItem) => TaskItemHiveModule(
              taskItemTitle: taskItem.taskItemTitle,
              taskItemIsCompleted: taskItem.taskItemIsCompleted,
              taskItemID: taskItem.taskItemID,
            ),
          )
          .toList(),
      taskListLabel: taskListLabel,
      taskListID: taskListID,
      taskListBackgroundColor: taskListBackgroundColor,
      taskListIsExpanded: taskListIsExpanded,
    );
  }
}

extension HiveToTaskList on TaskListHiveModule {
  TaskList toTaskList() {
    return TaskList(
      taskListTitle: taskListTitle,
      taskListPinned: taskListPinned,
      taskListItems: taskListItems
          .map(
            (taskItem) => TaskItem(
          taskItemTitle: taskItem.taskItemTitle,
          taskItemIsCompleted: taskItem.taskItemIsCompleted,
          taskItemID: taskItem.taskItemID,
        ),
      )
          .toList(),
      taskListLabel: taskListLabel,
      taskListID: taskListID,
      taskListBackgroundColor: taskListBackgroundColor,
      taskListIsExpanded: taskListIsExpanded,
    );
  }
}
