import 'package:hive/hive.dart';
import 'package:to_do_list/data/source/task_list_data_source/task_list_hive_data_source/module/task_item_hive_module.dart';
import 'package:to_do_list/data/task_item_module.dart';
import 'package:to_do_list/data/task_list_label.dart';
import 'package:to_do_list/data/task_list_module.dart';

part 'task_list_hive_module.g.dart';
@HiveType(typeId: 1)
class TaskListHiveModule extends HiveObject {
  @HiveField(0)
  String taskListTitle;

  @HiveField(1)
  String taskListID;

  @HiveField(2)
  bool taskListPinned;

  @HiveField(3)
  List<TaskItemHiveModule> taskListItems;

  @HiveField(4)
  TaskListLabel taskListLabel;

  @HiveField(5)
  int taskListBackgroundColor;

  @HiveField(6)
  bool taskListIsExpanded;

  TaskListHiveModule({
    required this.taskListTitle,
    required this.taskListPinned,
    required this.taskListItems,
    required this.taskListLabel,
    required this.taskListIsExpanded,
    required this.taskListBackgroundColor,
    required this.taskListID,
  }) ;

  TaskList taskListFromHiveModule(TaskListHiveModule hiveModule) {
    return TaskList(
      taskListTitle: hiveModule.taskListTitle,
      taskListPinned: hiveModule.taskListPinned,
      taskListItems: hiveModule.taskListItems
          .map(
            (taskItem) => TaskItem(
              taskItemTitle: taskItem.taskItemTitle,
              taskItemIsCompleted: taskItem.taskItemIsCompleted,
              taskItemID: taskItem.taskItemID,
            ),
          )
          .toList(),
      taskListLabel: hiveModule.taskListLabel,
      taskListID: hiveModule.taskListID,
      taskListIsExpanded: hiveModule.taskListIsExpanded,
      taskListBackgroundColor: hiveModule.taskListBackgroundColor,
    );
  }

  TaskListHiveModule taskListHiveModuleFromTaskList(TaskList taskList) {
    return TaskListHiveModule(
      taskListTitle: taskList.taskListTitle,
      taskListPinned: taskList.taskListPinned,
      taskListItems: taskList.taskListItems
          .map(
            (taskItem) => TaskItemHiveModule(
              taskItemTitle: taskItem.taskItemTitle,
              taskItemID: taskItem.taskItemID,
              taskItemIsCompleted: taskItem.taskItemIsCompleted,
            ),
          )
          .toList(),
      taskListLabel: taskList.taskListLabel,
      taskListBackgroundColor: taskList.taskListBackgroundColor,
      taskListIsExpanded: taskList.taskListIsExpanded,
      taskListID: taskList.taskListID,
    );
  }
}

