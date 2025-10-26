import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:to_do_list/common/exception.dart';
import 'package:to_do_list/data/repository/task_list_repository/i_task_list_repository.dart';
import 'package:to_do_list/data/task_list_module.dart';

part 'home_screen_event.dart';

part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final ITaskListRepository taskListRepository;

  HomeScreenBloc({required this.taskListRepository})
    : super(HomeScreenLoading()) {
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
          for(var taskList in taskLists){
            debugPrint('${taskList.taskListTitle} Expansion is: ${taskList.taskListIsExpanded.toString()}');
          }
          emit(
            HomeScreenSuccess(
              taskLists: taskLists,
              isPinned: isPinned,
            ),
          );
        } catch (e) {
          emit(
            HomeScreenError(exception: e is AppException ? e : AppException()),
          );
        }
      } else if (event is HomeScreenToggleTaskCompletion) {
        try {} catch (e) {
          emit(
            HomeScreenError(exception: e is AppException ? e : AppException()),
          );
        }
      }else if (event is HomeScreenToggleTaskListExpanded) {
        try {
          await taskListRepository.toggleTaskListExpansion(event.taskListID);

          if (state is HomeScreenSuccess) {
            final currentState = (state as HomeScreenSuccess);
            final updatedLists = await taskListRepository.getAllTaskLists(currentState.isPinned);

            emit(HomeScreenSuccess(
              taskLists: updatedLists,
              isPinned: currentState.isPinned,
            ));
          } else {
            throw Exception('Unsupported state');
          }
        } catch (e) {
          emit(HomeScreenError(
            exception: e is AppException ? e : AppException(),
          ));
        }
      } else {
        throw Exception('Event is unsupported');
      }
    });
  }
}
