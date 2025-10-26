// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_list_label.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskListLabelAdapter extends TypeAdapter<TaskListLabel> {
  @override
  final int typeId = 3;

  @override
  TaskListLabel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskListLabel.personal;
      case 1:
        return TaskListLabel.work;
      case 2:
        return TaskListLabel.finance;
      case 3:
        return TaskListLabel.other;
      default:
        return TaskListLabel.personal;
    }
  }

  @override
  void write(BinaryWriter writer, TaskListLabel obj) {
    switch (obj) {
      case TaskListLabel.personal:
        writer.writeByte(0);
        break;
      case TaskListLabel.work:
        writer.writeByte(1);
        break;
      case TaskListLabel.finance:
        writer.writeByte(2);
        break;
      case TaskListLabel.other:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskListLabelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
