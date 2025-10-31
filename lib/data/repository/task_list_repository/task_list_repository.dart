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
      String taskItemTitle,
  ) async {
    await taskListDataSource.addTaskItemToTaskList(taskListID, taskItemTitle);
    ITaskListRepository.taskListNotifier.notifyChanged();
  }

  @override
  Future<void> addTaskList(String taskListID) async {
    await taskListDataSource.addTaskList(taskListID);
    ITaskListRepository.taskListNotifier.notifyChanged();
  }

  @override
  Future<void> deleteTaskItem(String taskListID, String taskItemID) async {
    await taskListDataSource.deleteTaskItem(taskListID, taskItemID);
    ITaskListRepository.taskListNotifier.notifyChanged();
  }

  @override
  Future<void> deleteTaskList(String taskListID) async {
    await taskListDataSource.deleteTaskList(taskListID);
    ITaskListRepository.taskListNotifier.notifyChanged();
  }

  @override
  Future<List<TaskList>> getAllTaskLists(bool isPinned) async {
    final taskLists = await taskListDataSource.getAllTaskLists(isPinned);
    return taskLists;
  }

  @override
  Future<void> saveAllTaskLists(List<TaskList> taskLists) async {
    await taskListDataSource.saveAllTaskLists(taskLists);
  }

  @override
  Future<void> togglePinTaskList(String taskListID) async {
    await taskListDataSource.togglePinTaskList(taskListID);
    ITaskListRepository.taskListNotifier.notifyChanged();
  }

  @override
  Future<void> toggleTaskCompletion(
    String taskListID,
    String taskItemID,
  ) async {
    await taskListDataSource.toggleTaskCompletion(taskListID, taskItemID);
    ITaskListRepository.taskListNotifier.notifyChanged();
  }


  @override
  Future<void> updateTaskList(TaskList updatedTaskList) async {
    await taskListDataSource.updateTaskList(updatedTaskList);
  }

  @override
  Future<void> toggleTaskListExpansion(String taskListID) async {
    await taskListDataSource.toggleTaskListExpansion(taskListID);
  }

  @override
  Future<TaskList> getTaskList(String taskListID) async {
    return await taskListDataSource.getTaskList(taskListID);
  }

  @override
  Future<TaskItem> getTaskItem(String taskListID, String taskItemID) async{
    return await taskListDataSource.getTaskItem(taskListID, taskItemID);
  }

  @override
  Future<void> editTaskItemTitle(String taskListID, String taskItemID, String taskItemNewTitle) async{
    await taskListDataSource.editTaskItemTitle( taskListID,  taskItemID,  taskItemNewTitle);
    ITaskListRepository.taskListNotifier.notifyChanged();
  }

  @override
  Future<void> editTaskListTitle(String taskListID, String taskListNewTitle) async{
    await taskListDataSource.editTaskListTitle( taskListID,   taskListNewTitle);
    ITaskListRepository.taskListNotifier.notifyChanged();
  }

  @override
  Future<List<TaskList>> getSearchedTaskLists(String searchTerm) async{
    return await taskListDataSource.getSearchedTaskLists(searchTerm);
  }

}
