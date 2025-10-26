// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_list_hive_module.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskListHiveModuleAdapter extends TypeAdapter<TaskListHiveModule> {
  @override
  final int typeId = 1;

  @override
  TaskListHiveModule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskListHiveModule(
      taskListTitle: fields[0] as String,
      taskListPinned: fields[2] as bool,
      taskListItems: (fields[3] as List).cast<TaskItemHiveModule>(),
      taskListLabel: fields[4] as TaskListLabel,
      taskListIsExpanded: fields[6] as bool,
      taskListBackgroundColor: fields[5] as int?,
      taskListID: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskListHiveModule obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.taskListTitle)
      ..writeByte(1)
      ..write(obj.taskListID)
      ..writeByte(2)
      ..write(obj.taskListPinned)
      ..writeByte(3)
      ..write(obj.taskListItems)
      ..writeByte(4)
      ..write(obj.taskListLabel)
      ..writeByte(5)
      ..write(obj.taskListBackgroundColor)
      ..writeByte(6)
      ..write(obj.taskListIsExpanded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskListHiveModuleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
