import 'package:hive/hive.dart';

part 'task_item_hive_module.g.dart';

@HiveType(typeId: 0)
class TaskItemHiveModule extends HiveObject {
  @HiveField(0)
   String taskItemTitle;
  @HiveField(1)
   String taskItemID;
  @HiveField(2)
   bool taskItemIsCompleted;

  TaskItemHiveModule({
    required this.taskItemTitle,
    required this.taskItemID,
    required this.taskItemIsCompleted,
  });
}
