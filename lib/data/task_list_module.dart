import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:to_do_list/data/task_item_module.dart';
import 'package:to_do_list/data/task_list_label.dart';
import 'package:uuid/uuid.dart';

class TaskList {
  String taskListTitle;
  late String taskListID;
  bool taskListPinned;
  List<TaskItem> taskListItems;
  TaskListLabel taskListLabel;
  late int taskListBackgroundColor;
  bool taskListIsExpanded;

  TaskList({
    required this.taskListTitle,
    required this.taskListPinned,
    required this.taskListItems,
    required this.taskListLabel,
    required this.taskListIsExpanded,
    int? taskListBackgroundColor,
    String? taskListID,
  }) {
    final id = taskListID ?? const Uuid().v4();
    this.taskListID = id;
    this.taskListBackgroundColor =
        taskListBackgroundColor ?? getColorFromID(id);
  }

  Map<String, dynamic> toJson() {
    return {
      'taskListTitle': taskListTitle,
      'taskListID': taskListID,
      'taskListPinned': taskListPinned,
      'taskListItems': taskListItems.map((e) => e.toJson()).toList(),
      'taskListLabel': taskListLabel.toJson(),
      'taskListIsExpanded': taskListIsExpanded,
    };
  }

  factory TaskList.fromJson(Map<String, dynamic> json) =>
      TaskList(
        taskListTitle: json["taskListTitle"],
        taskListPinned: json['taskListPinned'],
        taskListLabel: TaskListLabel.fromJson(json['taskListLabel']),
        taskListID: json['taskListID'],
        taskListItems: (json['taskListItems'] as List)
            .map((e) => TaskItem.fromJson(e))
            .toList(),
        taskListIsExpanded: json['taskListIsExpanded'],
      );
}

int getColorFromID(String taskListID) {
  int stableHash = taskListID.codeUnits.fold(
    0,
        (prev, elem) => prev + elem * 37,
  );

  final random = Random(stableHash);
  final red = 50 + random.nextInt(100);
  final green = 150 + random.nextInt(106);
  final blue = 150 + random.nextInt(106);

  return Color.fromARGB(100, red, green, blue).toARGB32();
}

TaskList sampleTaskList() => TaskList(taskListTitle: 'Title',
    taskListPinned: false,
    taskListItems: [],
    taskListLabel: TaskListLabel.other,
    taskListIsExpanded: false);