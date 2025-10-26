import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:to_do_list/data/task_item_module.dart';
import 'package:to_do_list/data/task_list_label.dart';
import 'package:uuid/uuid.dart';

class TaskList {
  String taskListTitle;
  String taskListID;
  bool taskListPinned;
  List<TaskItem> taskListItems;
  TaskListLabel taskListLabel;
  int taskListBackgroundColor;
  bool taskListIsExpanded;

  TaskList({
    required this.taskListTitle,
    required this.taskListPinned,
    required this.taskListItems,
    required this.taskListLabel,
    required this.taskListIsExpanded,
    int? taskListBackgroundColor,
    String? taskListID,
  }) : taskListID = taskListID ?? Uuid().v4(),
       taskListBackgroundColor = getColorFromID(taskListID ?? Uuid().v4())
  ;

  Map<String, dynamic> toJson() {
    return {
      'taskListTitle': taskListTitle,
      'taskListID': taskListID,
      'taskListPinned': taskListPinned,
      'taskListItems': taskListItems.map((e) => e.toJson()).toList(),
      'taskListLabel' : taskListLabel.toJson(),
    'taskListIsExpanded' : taskListIsExpanded,
    };
  }

  factory TaskList.fromJson(Map<String, dynamic> json) => TaskList(
    taskListTitle: json["taskListTitle"],
    taskListPinned: json['taskListPinned'],
    taskListLabel: TaskListLabel.fromJson(json['taskListLabel']),
    taskListID: json['taskListID'],
    taskListItems: (json['taskListItems'] as List)
        .map((e) => TaskItem.fromJson(e))
        .toList(), taskListIsExpanded: json['taskListIsExpanded'],
  );
}


int getColorFromID(String taskListID) {
  final hash = taskListID.hashCode;
  final random = Random(hash);
  final red = 50 + random.nextInt(100);
  final green = 150 + random.nextInt(106);
  final blue = 150 + random.nextInt(106);

  return Color.fromARGB(100, red, green, blue).toARGB32();
}