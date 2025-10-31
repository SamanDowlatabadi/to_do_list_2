import 'package:to_do_list/data/task_item_module.dart';
import 'package:to_do_list/data/task_list_module.dart';

abstract class ITaskListDataSource {
  Future<List<TaskList>> getAllTaskLists(bool isPinned);

  Future<List<TaskList>> getSearchedTaskLists(String searchTerm);

  Future<TaskList> getTaskList(String taskListID);

  Future<TaskItem> getTaskItem(String taskListID, String taskItemID);

  Future<void> saveAllTaskLists(List<TaskList> taskLists);

  Future<void> addTaskList(String taskListID);

  Future<void> deleteTaskList(String taskListID);

  Future<void> updateTaskList(TaskList updatedTaskList);

  Future<void> togglePinTaskList(String taskListID);

  Future<void> addTaskItemToTaskList(String taskListID, String taskItemTitle);

  Future<void> updateTaskItem(String taskListID, TaskItem taskItem);

  Future<void> deleteTaskItem(String taskListID, String taskItemID);

  Future<void> toggleTaskCompletion(String taskListID, String taskItemID);

  Future<void> toggleTaskListExpansion(String taskListID);

  Future<void> editTaskItemTitle(String taskListID, String taskItemID, String taskItemNewTitle);

  Future<void> editTaskListTitle(String taskListID, String taskListNewTitle);
}
