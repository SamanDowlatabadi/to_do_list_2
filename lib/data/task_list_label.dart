import 'package:hive/hive.dart';
part 'task_list_label.g.dart';
@HiveType(typeId: 3)
enum TaskListLabel {
  @HiveField(0)
  personal,
  @HiveField(1)
  work,
  @HiveField(2)
  finance,
  @HiveField(3)
  other;
  @HiveField(4)

  String toJson() => name;

  static TaskListLabel fromJson(String value) {
    return TaskListLabel.values.firstWhere(
          (e) => e.name == value,
      orElse: () => TaskListLabel.other,
    );
  }
}