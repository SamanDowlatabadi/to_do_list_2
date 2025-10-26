// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_item_hive_module.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskItemHiveModuleAdapter extends TypeAdapter<TaskItemHiveModule> {
  @override
  final int typeId = 0;

  @override
  TaskItemHiveModule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskItemHiveModule(
      taskItemTitle: fields[0] as String,
      taskItemID: fields[1] as String,
      taskItemIsCompleted: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TaskItemHiveModule obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.taskItemTitle)
      ..writeByte(1)
      ..write(obj.taskItemID)
      ..writeByte(2)
      ..write(obj.taskItemIsCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskItemHiveModuleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
