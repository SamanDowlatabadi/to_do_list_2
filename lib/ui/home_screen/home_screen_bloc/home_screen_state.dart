part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenState {}

class HomeScreenLoading extends HomeScreenState {}

class HomeScreenSuccess extends HomeScreenState {
  final List<TaskList> taskLists;
  final bool isPinned;

  HomeScreenSuccess({required this.taskLists, required this.isPinned});
}

class HomeScreenError extends HomeScreenState {
  final AppException appException;

  HomeScreenError({required this.appException});
}

class HomeScreenEmptyState extends HomeScreenState {
  final bool isPinned;

  HomeScreenEmptyState({required this.isPinned});
}

