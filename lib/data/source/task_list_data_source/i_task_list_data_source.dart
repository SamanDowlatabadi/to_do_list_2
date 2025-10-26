import 'package:to_do_list/data/task_item_module.dart';
import 'package:to_do_list/data/task_list_module.dart';

abstract class ITaskListDataSource {
  Future<List<TaskList>> getAllTaskLists(bool isPinned);

  Future<void> saveAllTaskLists(List<TaskList> taskLists);

  Future<void> addTaskList(TaskList taskList);

  Future<void> deleteTaskList(String taskListID);

  Future<void> updateTaskList(TaskList updatedTaskList);

  Future<void> togglePinTaskList(String taskListID, bool isPinned);

  Future<void> addTaskItemToTaskList(String taskListID, TaskItem taskItem);

  Future<void> updateTaskItem(String taskListID, TaskItem taskItem);

  Future<void> deleteTaskItem(String taskListID, String taskItemID);

  Future<void> toggleTaskCompletion(String taskListID, String taskItemID);

  Future<void> toggleTaskListExpansion(String taskListID);
}