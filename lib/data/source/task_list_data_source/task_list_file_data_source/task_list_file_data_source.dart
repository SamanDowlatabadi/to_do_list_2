import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:to_do_list/data/task_item_module.dart';
import 'package:to_do_list/data/task_list_module.dart';

import '../i_task_list_data_source.dart';

class TaskListFileDataSource implements ITaskListDataSource {
  static const String fileName = 'tasksList.json';

  Future<File> get taskListsFile async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$fileName');
  }

  Future<List<TaskList>> _readAllTaskLists() async {
    try {
      final file = await taskListsFile;
      if (!await file.exists()) return [];

      final jsonString = await file.readAsString();
      if (jsonString.trim().isEmpty) return [];
      final List<dynamic> jsonData = jsonDecode(jsonString);
      return jsonData.map((e) => TaskList.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> _writeTaskLists(List<TaskList> taskLists) async {
    try {
      final file = await taskListsFile;
      final String jsonData = jsonEncode(
        taskLists.map((e) => e.toJson()).toList(),
      );
      await file.writeAsString(jsonData);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> addTaskItemToTaskList(
      String taskListID,
      TaskItem taskItem,
      ) async {
    try {
      final List<TaskList> taskLists = await _readAllTaskLists();
      final taskList = taskLists.firstWhere(
            (tempTaskList) => tempTaskList.taskListID == taskListID,
        orElse: () => throw Exception('List not found'),
      );
      taskList.taskListItems.add(taskItem);
      await _writeTaskLists(taskLists);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> addTaskList(TaskList taskList) async {
    try {
      final List<TaskList> taskLists = await _readAllTaskLists();
      final index = taskLists.indexWhere(
            (tempTaskList) => tempTaskList.taskListID == taskList.taskListID,
      );
      if (index == -1) {
        taskLists.add(taskList);
      } else {
        taskLists[index] = taskList;
      }
      await _writeTaskLists(taskLists);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteTaskItem(String taskListID, String taskItemID) async {
    try {
      final List<TaskList> taskLists = await _readAllTaskLists();
      final indexOfTaskList = taskLists.indexWhere(
            (tempTaskList) => tempTaskList.taskListID == taskListID,
      );
      if (indexOfTaskList != -1) {
        taskLists[indexOfTaskList].taskListItems.removeWhere(
              (tempTaskItem) => tempTaskItem.taskItemID == taskItemID,
        );
      } else {
        throw Exception('Task Item not found');
      }

      await _writeTaskLists(taskLists);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteTaskList(String taskListID) async {
    try {
      final List<TaskList> taskLists = await _readAllTaskLists();
      final indexOfTaskList = taskLists.indexWhere(
            (tempTaskList) => tempTaskList.taskListID == taskListID,
      );
      if (indexOfTaskList != -1) {
        taskLists.removeAt(indexOfTaskList);
      } else {
        throw Exception('Task List not found');
      }

      await _writeTaskLists(taskLists);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<TaskList>> getAllTaskLists(bool isPinned) async {
    try {
      final List<TaskList> taskLists = await _readAllTaskLists();
      if (isPinned) {
        return taskLists
            .where((tempTaskList) => tempTaskList.taskListPinned)
            .toList();
      } else {
        return taskLists;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> saveAllTaskLists(List<TaskList> taskLists) async {
    try {
      await _writeTaskLists(taskLists);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> togglePinTaskList(String taskListID, bool isPinned) async {
    try {
      final List<TaskList> taskLists = await _readAllTaskLists();
      final indexOfTaskList = taskLists.indexWhere(
            (tempTaskList) => tempTaskList.taskListID == taskListID,
      );
      if (indexOfTaskList == -1) {
        throw Exception('Task List not found');
      }
      taskLists[indexOfTaskList].taskListPinned = isPinned;

      await _writeTaskLists(taskLists);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> toggleTaskCompletion(
      String taskListID,
      String taskItemID,
      ) async {
    try {
      final List<TaskList> taskLists = await _readAllTaskLists();
      final indexOfTaskList = taskLists.indexWhere(
            (tempTaskList) => tempTaskList.taskListID == taskListID,
      );
      if (indexOfTaskList == -1) {
        throw Exception('Task List not found');
      }
      final indexOfTaskItem = taskLists[indexOfTaskList].taskListItems
          .indexWhere((tempTaskItem) => tempTaskItem.taskItemID == taskItemID);
      if (indexOfTaskItem == -1) {
        throw Exception('Task Item not found');
      }
      final taskItem =
      taskLists[indexOfTaskList].taskListItems[indexOfTaskItem];
      taskItem.taskItemIsCompleted = !taskItem.taskItemIsCompleted;
      await _writeTaskLists(taskLists);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateTaskItem(String taskListID, TaskItem taskItem) async {
    try {
      final List<TaskList> taskLists = await _readAllTaskLists();
      final indexOfTaskList = taskLists.indexWhere(
            (tempTaskList) => tempTaskList.taskListID == taskListID,
      );
      if (indexOfTaskList == -1) {
        throw Exception('Task List not found');
      }
      final indexOfTaskItem = taskLists[indexOfTaskList].taskListItems.indexWhere((tempTaskItem) => tempTaskItem.taskItemID == taskItem.taskItemID);
      if (indexOfTaskItem == -1) {
        throw Exception('Task Item not found');
      }
      taskLists[indexOfTaskList].taskListItems[indexOfTaskItem] = taskItem;
      await _writeTaskLists(taskLists);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateTaskList(TaskList updatedTaskList) async{
    try {
      final List<TaskList> taskLists = await _readAllTaskLists();
      final indexOfTaskList = taskLists.indexWhere(
            (tempTaskList) => tempTaskList.taskListID == updatedTaskList.taskListID,
      );
      if (indexOfTaskList == -1) {
        throw Exception('Task List not found');
      }
      taskLists[indexOfTaskList] = updatedTaskList;
      await _writeTaskLists(taskLists);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> toggleTaskListExpansion(String taskListID) async{
    try {
      final List<TaskList> taskLists = await _readAllTaskLists();
      final indexOfTaskList = taskLists.indexWhere(
            (tempTaskList) => tempTaskList.taskListID == taskListID,
      );
      if (indexOfTaskList == -1) {
        throw Exception('Task List not found');
      }

      taskLists[indexOfTaskList].taskListIsExpanded =  !taskLists[indexOfTaskList].taskListIsExpanded;
      await _writeTaskLists(taskLists);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
