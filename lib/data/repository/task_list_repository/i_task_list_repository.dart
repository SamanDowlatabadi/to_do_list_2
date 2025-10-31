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

  Future<List<TaskList>> getSearchedTaskLists(String searchTerm);

  Future<TaskList> getTaskList(String taskListID);

  Future<TaskItem> getTaskItem(String taskListID, String taskItemID);

  Future<void> addTaskList(String taskListID);

  Future<void> deleteTaskList(String taskListID);

  Future<void> togglePinTaskList(String taskListID);

  Future<void> addTaskItemToTaskList(String taskListID, String taskItemTitle);

  Future<void> editTaskItemTitle(String taskListID, String taskItemID, String taskItemNewTitle);

  Future<void> editTaskListTitle(String taskListID, String taskListNewTitle);

  Future<void> deleteTaskItem(String taskListID, String taskItemID);

  Future<void> toggleTaskCompletion(String taskListID, String taskItemID);

  Future<void> toggleTaskListExpansion(String taskListID);
}
