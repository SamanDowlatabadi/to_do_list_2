// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:to_do_list/common/exception.dart';
import 'package:to_do_list/data/repository/task_list_repository/i_task_list_repository.dart';
import 'package:to_do_list/data/task_list_module.dart';

part 'search_screen_event.dart';
part 'search_screen_state.dart';

class SearchScreenBloc extends Bloc<SearchScreenEvent, SearchScreenState> {
  final ITaskListRepository taskListRepository;
  SearchScreenBloc({required this.taskListRepository}) : super(SearchScreenLoading()) {
    on<SearchScreenEvent>((event, emit)async {
      try{
        if (event is SearchScreenStarted) {
          final taskList = await taskListRepository.getSearchedTaskLists(
              event.searchTerm);
          emit(SearchScreenSuccess(taskLists: taskList));
        }
      }catch(e){
        emit(SearchScreenError(appException: e is AppException ? e : AppException()));
      }
    });
  }
}
