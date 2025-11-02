part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenEvent {}

class HomeScreenStarted extends HomeScreenEvent {
  final bool isPinned;

  HomeScreenStarted({required this.isPinned});
}

class HomeScreenRefresh extends HomeScreenEvent {}

class HomeScreenToggleTaskCompletion extends HomeScreenEvent {
  final String taskListID;
  final String taskItemID;

  HomeScreenToggleTaskCompletion({
    required this.taskListID,
    required this.taskItemID,
  });
}

class HomeScreenToggleTaskListExpanded extends HomeScreenEvent {
  final String taskListID;

  HomeScreenToggleTaskListExpanded({required this.taskListID});
}

class HomeScreenAddTaskList extends HomeScreenEvent {}

class HomeScreenDeleteTaskList extends HomeScreenEvent {
  final String taskListID;

  HomeScreenDeleteTaskList({required this.taskListID});
}
