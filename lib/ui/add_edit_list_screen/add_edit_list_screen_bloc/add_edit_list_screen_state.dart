part of 'add_edit_list_screen_bloc.dart';

@immutable
sealed class AddEditListScreenState {}

class AddEditListScreenLoading extends AddEditListScreenState {}

class AddEditListScreenSuccess extends AddEditListScreenState{
  final TaskList taskList;

  AddEditListScreenSuccess({required this.taskList});
}

class AddEditListScreenError extends AddEditListScreenState{
  final AppException appException;

  AddEditListScreenError({required this.appException});
}