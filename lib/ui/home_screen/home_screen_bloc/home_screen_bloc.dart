// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:to_do_list/common/exception.dart';
import 'package:to_do_list/data/repository/task_list_repository/i_task_list_repository.dart';
import 'package:to_do_list/data/task_list_module.dart';

part 'home_screen_event.dart';

part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final ITaskListRepository taskListRepository;
  late final VoidCallback _onChangedRepository;

  HomeScreenBloc({required this.taskListRepository})
    : super(HomeScreenLoading()) {
    _onChangedRepository = () {
      add(HomeScreenRefresh());
    };

    ITaskListRepository.taskListNotifier.addListener(_onChangedRepository);

    on<HomeScreenEvent>((event, emit) async {
      try {
        // is Pinning checking
        bool isPinned;
        if (event is HomeScreenStarted) {
          isPinned = event.isPinned;
        } else if (event is HomeScreenRefresh && state is HomeScreenSuccess) {
          isPinned = (state as HomeScreenSuccess).isPinned;
        } else {
          isPinned = false;
        }

        // events checking
        if (event is HomeScreenStarted || event is HomeScreenRefresh) {
          final taskLists = await taskListRepository.getAllTaskLists(isPinned);
          if (taskLists.isEmpty) {
            emit(HomeScreenEmptyState(isPinned: isPinned));
          } else {
            emit(HomeScreenSuccess(taskLists: taskLists, isPinned: isPinned));
          }
        } else if (event is HomeScreenToggleTaskCompletion) {
          await taskListRepository.toggleTaskCompletion(
            event.taskListID,
            event.taskItemID,
          );
        } else if (event is HomeScreenToggleTaskListExpanded) {
          await taskListRepository.toggleTaskListExpansion(event.taskListID);
        } else if (event is HomeScreenDeleteTaskList) {
          await taskListRepository.deleteTaskList(event.taskListID);
        } else {
          throw Exception('Event is unsupported');
        }
      } catch (e) {
        emit(
          HomeScreenError(appException: e is AppException ? e : AppException()),
        );
      }
    });
  }

  @override
  Future<void> close() {
    ITaskListRepository.taskListNotifier.removeListener(_onChangedRepository);
    return super.close();
  }
}
