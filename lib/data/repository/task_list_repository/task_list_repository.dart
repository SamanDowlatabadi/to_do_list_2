import 'package:to_do_list/data/repository/task_list_repository/i_task_list_repository.dart';
import 'package:to_do_list/data/source/task_list_data_source/i_task_list_data_source.dart';
import 'package:to_do_list/data/task_item_module.dart';
import 'package:to_do_list/data/task_list_module.dart';

class TaskListRepository implements ITaskListRepository {
  final ITaskListDataSource taskListDataSource;

  TaskListRepository({required this.taskListDataSource});

  @override
  Future<void> addTaskItemToTaskList(
      String taskListID,
      TaskItem taskItem,
      ) async {
    await taskListDataSource.addTaskItemToTaskList(taskListID, taskItem);
  }

  @override
  Future<void> addTaskList(TaskList taskList) async {
    await taskListDataSource.addTaskList(taskList);
  }

  @override
  Future<void> deleteTaskItem(String taskListID, String taskItemID) async {
    await taskListDataSource.deleteTaskItem(taskListID, taskItemID);
  }

  @override
  Future<void> deleteTaskList(String taskListID) async {
    await taskListDataSource.deleteTaskList(taskListID);
  }

  @override
  Future<List<TaskList>> getAllTaskLists(bool isPinned) async {
    return await taskListDataSource.getAllTaskLists(isPinned);
  }

  @override
  Future<void> saveAllTaskLists(List<TaskList> taskLists) async {
    await taskListDataSource.saveAllTaskLists(taskLists);
  }

  @override
  Future<void> togglePinTaskList(String taskListID, bool isPinned) async {
    await taskListDataSource.togglePinTaskList(taskListID, isPinned);
  }

  @override
  Future<void> toggleTaskCompletion(
      String taskListID,
      String taskItemID,
      ) async {
    await taskListDataSource.toggleTaskCompletion(taskListID, taskItemID);
  }

  @override
  Future<void> updateTaskItem(String taskListID, TaskItem taskItem) async {
    await taskListDataSource.updateTaskItem(taskListID, taskItem);
  }

  @override
  Future<void> updateTaskList(TaskList updatedTaskList) async {
    await taskListDataSource.updateTaskList(updatedTaskList);
  }

  @override
  Future<void> toggleTaskListExpansion(String taskListID) async{
    await taskListDataSource.toggleTaskListExpansion(taskListID);
  }
}
