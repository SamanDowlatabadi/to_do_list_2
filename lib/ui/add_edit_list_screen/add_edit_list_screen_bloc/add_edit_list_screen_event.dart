part of 'add_edit_list_screen_bloc.dart';

@immutable
sealed class AddEditListScreenEvent {}

class AddEditListScreenStarted extends AddEditListScreenEvent{
  final String taskListID;

  AddEditListScreenStarted({required this.taskListID});
}

class AddEditListScreenTaskListExpansion extends AddEditListScreenEvent{
  final String taskListID;

  AddEditListScreenTaskListExpansion({required this.taskListID});
}