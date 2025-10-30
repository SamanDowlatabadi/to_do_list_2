part of 'add_edit_list_screen_bloc.dart';

@immutable
sealed class AddEditListScreenEvent {}

class AddEditListScreenStarted extends AddEditListScreenEvent {
   final String taskListID;
   final bool? isNewTaskList;

  AddEditListScreenStarted( {required this.taskListID,this.isNewTaskList = false,});
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

class AddEditTaskScreenStartEditTask extends AddEditListScreenEvent{
  final String taskListID;
  final String taskItemID;

  AddEditTaskScreenStartEditTask({required this.taskListID, required this.taskItemID});
}

class AddEditListScreenEditTaskTitleChanged extends AddEditListScreenEvent {
  final String taskListID;
  final String taskItemID;
  final String newTaskItemTitle;

  AddEditListScreenEditTaskTitleChanged({
    required this.taskListID,
    required this.taskItemID,
    required this.newTaskItemTitle,
  });
}

class AddEditListScreenEditTaskTitleSaved extends AddEditListScreenEvent {
  final String taskListID;
  final String taskItemID;
  final String taskItemNewTitle;

  AddEditListScreenEditTaskTitleSaved({
    required this.taskListID,
    required this.taskItemID,
    required this.taskItemNewTitle,
  });
}


class AddEditTaskScreenStartEditTaskList extends AddEditListScreenEvent{
  final String taskListID;

  AddEditTaskScreenStartEditTaskList({required this.taskListID});
}

class AddEditListScreenEditTaskListTitleChanged extends AddEditListScreenEvent {
  final String taskListID;
  final String newTaskListTitle;

  AddEditListScreenEditTaskListTitleChanged({
    required this.taskListID,
    required this.newTaskListTitle,
  });
}

class AddEditListScreenEditTaskListTitleSaved extends AddEditListScreenEvent {
  final String taskListID;
  final String taskListNewTitle;

  AddEditListScreenEditTaskListTitleSaved({
    required this.taskListID,
    required this.taskListNewTitle,
  });
}


class AddEditListScreenDeleteTaskItem extends AddEditListScreenEvent{
  final String taskListID;
  final String taskItemID;

  AddEditListScreenDeleteTaskItem({required this.taskListID, required this.taskItemID});

}


class AddEditListScreenStartAddTask extends AddEditListScreenEvent{
  final String taskListID;

  AddEditListScreenStartAddTask({required this.taskListID});
}

class AddEditListScreenStartAddTaskSubmitted extends AddEditListScreenEvent{
  final String taskListID;
  final String newTaskItemTitle;

  AddEditListScreenStartAddTaskSubmitted({required this.taskListID, required this.newTaskItemTitle});
}

class AddEditListScreenDeleteTaskList extends AddEditListScreenEvent{
  final String taskListID;

  AddEditListScreenDeleteTaskList({required this.taskListID});
}