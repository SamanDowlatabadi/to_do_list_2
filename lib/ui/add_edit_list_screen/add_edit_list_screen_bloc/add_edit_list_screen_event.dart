part of 'add_edit_list_screen_bloc.dart';

@immutable
sealed class AddEditListScreenEvent {}

class AddEditListScreenStarted extends AddEditListScreenEvent {
  final String taskListID;

  AddEditListScreenStarted({required this.taskListID});
}

class AddEditListScreenTaskListTogglePin extends AddEditListScreenEvent {
  final String taskListID;

  AddEditListScreenTaskListTogglePin({required this.taskListID});
}

class AddEditListScreenToggleTaskCompletion extends AddEditListScreenEvent {
  final String taskListID;
  final String taskItemID;

  AddEditListScreenToggleTaskCompletion({
    required this.taskListID,
    required this.taskItemID,
  });
}