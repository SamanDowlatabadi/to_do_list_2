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
      debugPrint('Task Lists Changed');
    };

    ITaskListRepository.taskListNotifier.addListener(_onChangedRepository);

    on<HomeScreenEvent>((event, emit) async {
      if (event is HomeScreenStarted || event is HomeScreenRefresh) {
        try {
          bool isPinned;
          if (event is HomeScreenStarted) {
            isPinned = event.isPinned;
          } else if (event is HomeScreenRefresh && state is HomeScreenSuccess) {
            isPinned = (state as HomeScreenSuccess).isPinned;
          } else {
            isPinned = false;
          }
          final taskLists = await taskListRepository.getAllTaskLists(isPinned);
          if (taskLists.isEmpty) {
            emit(HomeScreenEmptyState(isPinned: isPinned));
          } else {
            emit(HomeScreenSuccess(taskLists: taskLists, isPinned: isPinned));
          }
        } catch (e) {
          emit(
            HomeScreenError(
              appException: e is AppException ? e : AppException(),
            ),
          );
        }
      } else if (event is HomeScreenToggleTaskCompletion) {
        try {
          bool isPinned;
          if (state is HomeScreenSuccess) {
            isPinned = (state as HomeScreenSuccess).isPinned;
          } else {
            isPinned = false;
          }
          await taskListRepository.toggleTaskCompletion(
            event.taskListID,
            event.taskItemID,
          );
          final taskLists = await taskListRepository.getAllTaskLists(isPinned);
          emit(HomeScreenSuccess(taskLists: taskLists, isPinned: isPinned));
        } catch (e) {
          emit(
            HomeScreenError(
              appException: e is AppException ? e : AppException(),
            ),
          );
        }
      } else if (event is HomeScreenToggleTaskListExpanded) {
        try {
          await taskListRepository.toggleTaskListExpansion(event.taskListID);

          if (state is HomeScreenSuccess) {
            final currentState = (state as HomeScreenSuccess);
            final updatedLists = await taskListRepository.getAllTaskLists(
              currentState.isPinned,
            );

            emit(
              HomeScreenSuccess(
                taskLists: updatedLists,
                isPinned: currentState.isPinned,
              ),
            );
          } else {
            throw Exception('Unsupported state');
          }
        } catch (e) {
          emit(
            HomeScreenError(
              appException: e is AppException ? e : AppException(),
            ),
          );
        }
      } else if(event is HomeScreenDeleteTaskList){
        try{
          await taskListRepository.deleteTaskList(event.taskListID);
         }catch (e) {
          emit(
            HomeScreenError(
              appException: e is AppException ? e : AppException(),
            ),
          );
        }
      }
      
      else {
        throw Exception('Event is unsupported');
      }
    });
  }

  @override
  Future<void> close() {
    ITaskListRepository.taskListNotifier.removeListener(_onChangedRepository);
    return super.close();
  }
}
