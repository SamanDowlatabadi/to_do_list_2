import 'package:flutter/foundation.dart';
import 'package:to_do_list/data/repository/task_list_repository/task_list_repository.dart';
import 'package:to_do_list/data/source/task_list_data_source/task_list_hive_data_source/task_list_hive_data_source.dart';
import 'package:to_do_list/data/task_item_module.dart';
import 'package:to_do_list/data/task_list_module.dart';

final taskListRepository = TaskListRepository(
  taskListDataSource: TaskListHiveDataSource(),
);

class TaskListNotifier extends ChangeNotifier {
  void notifyChanged() => notifyListeners();
}

abstract class ITaskListRepository {
  static final TaskListNotifier taskListNotifier = TaskListNotifier();

  Future<List<TaskList>> getAllTaskLists(bool isPinned);

  Future<TaskList> getTaskList(String taskListID);

  Future<void> saveAllTaskLists(List<TaskList> taskLists);

  Future<void> addTaskList(TaskList taskList);

  Future<void> deleteTaskList(String taskListID);

  Future<void> updateTaskList(TaskList updatedTaskList);

  Future<void> togglePinTaskList(String taskListID);

  Future<void> addTaskItemToTaskList(String taskListID, TaskItem taskItem);

  Future<void> updateTaskItem(String taskListID, TaskItem taskItem);

  Future<void> deleteTaskItem(String taskListID, String taskItemID);

  Future<void> toggleTaskCompletion(String taskListID, String taskItemID);

  Future<void> toggleTaskListExpansion(String taskListID);
}
