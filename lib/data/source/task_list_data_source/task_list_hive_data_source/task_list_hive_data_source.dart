import 'package:hive/hive.dart';
import 'package:to_do_list/data/source/task_list_data_source/i_task_list_data_source.dart';
import 'package:to_do_list/data/source/task_list_data_source/task_list_hive_data_source/module/task_list_hive_module.dart';
import 'package:to_do_list/data/task_item_module.dart';
import 'package:to_do_list/data/task_list_label.dart';
import 'package:to_do_list/data/task_list_module.dart';
import 'mapper/task_item_mapper.dart';
import 'mapper/task_list_mapper.dart';

class TaskListHiveDataSource implements ITaskListDataSource {
  static final String boxName = 'taskLists';

  @override
  Future<List<TaskList>> getAllTaskLists(bool isPinned) async {
    try {
      final box = Hive.box<TaskListHiveModule>(boxName);
      final List<TaskListHiveModule> taskListsHiveModule = box.values.toList();
      final List<TaskList> taskLists = taskListsHiveModule
          .map((e) => e.toTaskList())
          .toList();
      if (isPinned) {
        return taskLists.where((taskList) => taskList.taskListPinned).toList();
      } else {
        return taskLists;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> addTaskItemToTaskList(
    String taskListID,
    String taskItemTitle,
  ) async {
    try {
      final box = Hive.box<TaskListHiveModule>(boxName);
      final taskListHiveModule = box.get(taskListID);
      if (taskListHiveModule == null) {
        throw Exception('Task List not found');
      }
      final isDuplicate = taskListHiveModule.taskListItems.any(
        (taskItem) =>
            taskItem.taskItemTitle.trim().toLowerCase() ==
            taskItemTitle.toLowerCase(),
      );
      final taskItemHiveModule = TaskItem(
        taskItemTitle: taskItemTitle,
        taskItemIsCompleted: false,
      ).toHive();
      if (!isDuplicate) {
        taskListHiveModule.taskListItems.add(taskItemHiveModule);
        await box.put(taskListID, taskListHiveModule);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> addTaskList(String taskListID) async {
    try {
      final box = Hive.box<TaskListHiveModule>(boxName);
      final TaskList taskList = TaskList(
        taskListTitle: 'Title',
        taskListID: taskListID,
        taskListPinned: false,
        taskListItems: [],
        taskListLabel: TaskListLabel.personal,
        taskListIsExpanded: false,
      );
      final taskListHiveModule = taskList.toHive();
      await box.put(taskListHiveModule.taskListID, taskListHiveModule);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteTaskItem(String taskListID, String taskItemID) async {
    try {
      final box = Hive.box<TaskListHiveModule>(boxName);
      final taskListHiveModule = box.get(taskListID);
      if (taskListHiveModule == null) {
        throw Exception('Task List not found');
      }
      if (taskListHiveModule.taskListItems.isEmpty) {
        throw Exception('Task Item is empty');
      }

      final taskItemsHiveModule = taskListHiveModule.taskListItems;
      taskItemsHiveModule.removeWhere((e) => e.taskItemID == taskItemID);

      await box.put(taskListID, taskListHiveModule);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteTaskList(String taskListID) async {
    try {
      final box = Hive.box<TaskListHiveModule>(boxName);
      if (!box.containsKey(taskListID)) {
        throw Exception('Task List not found');
      }
      await box.delete(taskListID);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> saveAllTaskLists(List<TaskList> taskLists) async {
    try {
      final box = Hive.box<TaskListHiveModule>(boxName);
      await box.clear();
      await box.putAll({
        for (var taskList in taskLists) taskList.taskListID: taskList.toHive(),
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> togglePinTaskList(String taskListID) async {
    try {
      final box = Hive.box<TaskListHiveModule>(boxName);
      final taskListHiveModule = box.get(taskListID);
      if (taskListHiveModule == null) {
        throw Exception('Task List not found');
      }

      taskListHiveModule.taskListPinned = !taskListHiveModule.taskListPinned;
      await box.put(taskListID, taskListHiveModule);
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
      final box = Hive.box<TaskListHiveModule>(boxName);
      final taskListHiveModule = box.get(taskListID);
      if (taskListHiveModule == null) {
        throw Exception('Task List not found');
      }
      final indexOfTaskItem = taskListHiveModule.taskListItems.indexWhere(
        (taskItem) => taskItem.taskItemID == taskItemID,
      );
      if (indexOfTaskItem == -1) {
        throw Exception('Task Item not found');
      }
      final taskItemHiveModule =
          taskListHiveModule.taskListItems[indexOfTaskItem];

      taskItemHiveModule.taskItemIsCompleted =
          !taskItemHiveModule.taskItemIsCompleted;
      await box.put(taskListID, taskListHiveModule);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> toggleTaskListExpansion(String taskListID) async {
    try {
      final box = Hive.box<TaskListHiveModule>(boxName);
      final taskListHiveModule = box.get(taskListID);
      if (taskListHiveModule == null) {
        throw Exception('Task List not found');
      }
      taskListHiveModule.taskListIsExpanded =
          !taskListHiveModule.taskListIsExpanded;
      await box.put(taskListID, taskListHiveModule);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateTaskItem(String taskListID, TaskItem taskItem) async {
    try {
      final box = Hive.box<TaskListHiveModule>(boxName);
      final taskListHiveModule = box.get(taskListID);
      if (taskListHiveModule == null) {
        throw Exception('Task List not found');
      }
      final indexOfTaskItem = taskListHiveModule.taskListItems.indexWhere(
        (tempTaskItem) => tempTaskItem.taskItemID == taskItem.taskItemID,
      );
      if (indexOfTaskItem == -1) {
        throw Exception('Task Item not found');
      }

      taskListHiveModule.taskListItems[indexOfTaskItem] = taskItem.toHive();

      await box.put(taskListID, taskListHiveModule);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<TaskList> getTaskList(String taskListID) async {
    try {
      final box = Hive.box<TaskListHiveModule>(boxName);
      final taskListHiveModule = box.get(taskListID);
      if (taskListHiveModule == null) {
        throw Exception('Task List not found');
      }
      return taskListHiveModule.toTaskList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<TaskItem> getTaskItem(String taskListID, String taskItemID) async {
    try {
      final box = Hive.box<TaskListHiveModule>(boxName);
      final taskListHiveModule = box.get(taskListID);
      if (taskListHiveModule == null) {
        throw Exception('Task List not found');
      }
      final indexOfTaskItem = taskListHiveModule.taskListItems.indexWhere(
        (tempTaskItem) => tempTaskItem.taskItemID == taskItemID,
      );
      if (indexOfTaskItem == -1) {
        throw Exception('Task Item not found');
      }
      return taskListHiveModule.taskListItems[indexOfTaskItem].toTaskItem();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> editTaskItemTitle(
    String taskListID,
    String taskItemID,
    String taskItemNewTitle,
  ) async {
    try {
      final box = Hive.box<TaskListHiveModule>(boxName);
      final taskListHiveModule = box.get(taskListID);
      if (taskListHiveModule == null) {
        throw Exception('Task List not found');
      }
      final indexOfTaskItem = taskListHiveModule.taskListItems.indexWhere(
        (taskItem) => taskItem.taskItemID == taskItemID,
      );
      if (indexOfTaskItem == -1) {
        throw Exception('Task Item not found');
      }
      final taskItemHiveModule =
          taskListHiveModule.taskListItems[indexOfTaskItem];

      taskItemHiveModule.taskItemTitle = taskItemNewTitle;
      await box.put(taskListID, taskListHiveModule);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> editTaskListTitle(
    String taskListID,
    String taskListNewTitle,
  ) async {
    try {
      final box = Hive.box<TaskListHiveModule>(boxName);
      final taskListHiveModule = box.get(taskListID);
      if (taskListHiveModule == null) {
        throw Exception('Task List not found');
      }

      taskListHiveModule.taskListTitle = taskListNewTitle;
      await box.put(taskListID, taskListHiveModule);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<TaskList>> getSearchedTaskLists(String searchTerm) async {
    try {
      final box = Hive.box<TaskListHiveModule>(boxName);
      final List<TaskListHiveModule> taskListsHiveModule = box.values.toList();
      final List<TaskList> taskLists = taskListsHiveModule
          .map((e) => e.toTaskList())
          .toList();

      return taskLists
          .where(
            (e) => e.taskListTitle.trim().toLowerCase().contains(
              searchTerm.trim().toLowerCase(),
            ),
          )
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
