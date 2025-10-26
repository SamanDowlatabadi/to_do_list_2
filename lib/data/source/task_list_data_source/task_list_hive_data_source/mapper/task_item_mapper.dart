import 'package:to_do_list/data/source/task_list_data_source/task_list_hive_data_source/module/task_item_hive_module.dart';
import 'package:to_do_list/data/task_item_module.dart';

extension TaskItemToHive on TaskItem {
  TaskItemHiveModule toHive() {
    return TaskItemHiveModule(
      taskItemTitle: taskItemTitle,
      taskItemID: taskItemID,
      taskItemIsCompleted: taskItemIsCompleted,
    );
  }
}

extension HiveToTaskItem on TaskItemHiveModule {
  TaskItem toTaskItem() {
    return TaskItem(
      taskItemID: taskItemID,
      taskItemTitle: taskItemTitle,
      taskItemIsCompleted: taskItemIsCompleted,
    );
  }
}
