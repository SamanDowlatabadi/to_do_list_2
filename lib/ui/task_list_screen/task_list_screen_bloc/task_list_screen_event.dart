part of 'task_list_screen_bloc.dart';

@immutable
sealed class TaskListScreenEvent {}

class TaskListScreenStarted extends TaskListScreenEvent {
  final String taskListID;
  final bool? isNewTaskList;

  TaskListScreenStarted({required this.taskListID, this.isNewTaskList = false});
}

class TaskListScreenTaskListTogglePin extends TaskListScreenEvent {
  final String taskListID;

  TaskListScreenTaskListTogglePin({required this.taskListID});
}

class TaskListScreenToggleTaskCompletion extends TaskListScreenEvent {
  final String taskListID;
  final String taskItemID;

  TaskListScreenToggleTaskCompletion({
    required this.taskListID,
    required this.taskItemID,
  });
}

class TaskTaskScreenStartEditTask extends TaskListScreenEvent {
  final String taskListID;
  final String taskItemID;

  TaskTaskScreenStartEditTask({
    required this.taskListID,
    required this.taskItemID,
  });
}

class TaskListScreenEditTaskTitleChanged extends TaskListScreenEvent {
  final String taskListID;
  final String taskItemID;
  final String newTaskItemTitle;

  TaskListScreenEditTaskTitleChanged({
    required this.taskListID,
    required this.taskItemID,
    required this.newTaskItemTitle,
  });
}

class TaskListScreenEditTaskTitleSaved extends TaskListScreenEvent {
  final String taskListID;
  final String taskItemID;
  final String taskItemNewTitle;

  TaskListScreenEditTaskTitleSaved({
    required this.taskListID,
    required this.taskItemID,
    required this.taskItemNewTitle,
  });
}

class TaskTaskScreenStartEditTaskList extends TaskListScreenEvent {
  final String taskListID;

  TaskTaskScreenStartEditTaskList({required this.taskListID});
}

class TaskListScreenEditTaskListTitleChanged extends TaskListScreenEvent {
  final String taskListID;
  final String newTaskListTitle;

  TaskListScreenEditTaskListTitleChanged({
    required this.taskListID,
    required this.newTaskListTitle,
  });
}

class TaskListScreenEditTaskListTitleSaved extends TaskListScreenEvent {
  final String taskListID;
  final String taskListNewTitle;

  TaskListScreenEditTaskListTitleSaved({
    required this.taskListID,
    required this.taskListNewTitle,
  });
}

class TaskListScreenDeleteTaskItem extends TaskListScreenEvent {
  final String taskListID;
  final String taskItemID;

  TaskListScreenDeleteTaskItem({
    required this.taskListID,
    required this.taskItemID,
  });
}

class TaskListScreenStartAddTask extends TaskListScreenEvent {
  final String taskListID;

  TaskListScreenStartAddTask({required this.taskListID});
}

class TaskListScreenStartAddTaskSubmitted extends TaskListScreenEvent {
  final String taskListID;
  final String newTaskItemTitle;

  TaskListScreenStartAddTaskSubmitted({
    required this.taskListID,
    required this.newTaskItemTitle,
  });
}

class TaskListScreenDeleteTaskList extends TaskListScreenEvent {
  final String taskListID;

  TaskListScreenDeleteTaskList({required this.taskListID});
}
