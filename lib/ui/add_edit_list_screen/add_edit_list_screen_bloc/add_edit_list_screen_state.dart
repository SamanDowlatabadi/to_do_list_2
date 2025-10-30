part of 'add_edit_list_screen_bloc.dart';

@immutable
sealed class AddEditListScreenState {}

class AddEditListScreenLoading extends AddEditListScreenState {}

class AddEditListScreenSuccess extends AddEditListScreenState {
  final TaskList taskList;
  final String? editingID;
  final String? editingTitle;
  final bool isAddingTask;
  AddEditListScreenSuccess( {required this.taskList,  this.editingID ,  this.editingTitle , this.isAddingTask = false});
}

class AddEditListScreenError extends AddEditListScreenState {
  final AppException appException;

  AddEditListScreenError({required this.appException});
}
