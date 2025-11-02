part of 'search_screen_bloc.dart';

@immutable
sealed class SearchScreenState {}

class SearchScreenLoading extends SearchScreenState {}

class SearchScreenSuccess extends SearchScreenState {
  final List<TaskList> taskLists;

  SearchScreenSuccess({required this.taskLists});
}

class SearchScreenError extends SearchScreenState {
  final AppException appException;

  SearchScreenError({required this.appException});
}
