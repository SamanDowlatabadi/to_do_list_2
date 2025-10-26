part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenState {}

class HomeScreenLoading extends HomeScreenState {}

class HomeScreenError extends HomeScreenState {
  final AppException exception;

  HomeScreenError({required this.exception});
}

class HomeScreenSuccess extends HomeScreenState {
  final List<TaskList> taskLists;
  final bool isPinned;

  HomeScreenSuccess({
    required this.taskLists,
    required this.isPinned,
  });
}
