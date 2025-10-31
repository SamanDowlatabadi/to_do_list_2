part of 'task_list_screen_bloc.dart';

@immutable
sealed class TaskListScreenState {}

class TaskListScreenLoading extends TaskListScreenState {}

class TaskListScreenSuccess extends TaskListScreenState {
  final TaskList taskList;
  final String? editingID;
  final String? editingTitle;
  final bool isAddingTask;
  TaskListScreenSuccess( {required this.taskList,  this.editingID ,  this.editingTitle , this.isAddingTask = false});
}

class TaskListScreenError extends TaskListScreenState {
  final AppException appException;

  TaskListScreenError({required this.appException});
}
