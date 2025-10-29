import 'package:uuid/uuid.dart';

class TaskItem {
  String taskItemTitle;
  String taskItemID;
  bool taskItemIsCompleted;

  TaskItem({
    required this.taskItemTitle,
    required this.taskItemIsCompleted,
    String? taskItemID,
  }) : taskItemID = taskItemID ?? const Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      'taskItemTitle': taskItemTitle,
      'taskItemID': taskItemID,
      'taskItemIsCompleted': taskItemIsCompleted,
    };
  }

  factory TaskItem.fromJson(Map<String, dynamic> json) => TaskItem(
    taskItemTitle: json['taskItemTitle'],
    taskItemIsCompleted: json['taskItemIsCompleted'],
    taskItemID: json['taskItemID'],
  );
}
