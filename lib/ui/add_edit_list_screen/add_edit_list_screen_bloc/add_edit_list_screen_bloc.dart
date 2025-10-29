// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:to_do_list/common/exception.dart';
import 'package:to_do_list/data/repository/task_list_repository/i_task_list_repository.dart';
import 'package:to_do_list/data/task_list_module.dart';

part 'add_edit_list_screen_event.dart';

part 'add_edit_list_screen_state.dart';

class AddEditListScreenBloc
    extends Bloc<AddEditListScreenEvent, AddEditListScreenState> {
  final ITaskListRepository taskListRepository;

  AddEditListScreenBloc({required this.taskListRepository})
    : super(AddEditListScreenLoading()) {

    on<AddEditListScreenEvent>((event, emit) async {
      if (event is AddEditListScreenStarted) {
        try {
          final taskList = await taskListRepository.getTaskList(
            event.taskListID,
          );
          emit(AddEditListScreenSuccess(taskList: taskList));
        } catch (e) {
          emit(
            AddEditListScreenError(
              appException: e is AppException ? e : AppException(),
            ),
          );
        }
      } else if(event is AddEditListScreenTaskListExpansion){
        try {
          await taskListRepository.togglePinTaskList(event.taskListID);
          final taskList = await taskListRepository.getTaskList(
            event.taskListID,
          );
          emit(AddEditListScreenSuccess(taskList: taskList));
        } catch (e) {
          emit(
            AddEditListScreenError(
              appException: e is AppException ? e : AppException(),
            ),
          );
        }
      }
    });
  }
}
