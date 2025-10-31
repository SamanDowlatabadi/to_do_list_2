import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/data/repository/task_list_repository/i_task_list_repository.dart';
import 'package:to_do_list/ui/common/app_error_widget.dart';
import 'package:to_do_list/ui/home_screen/task_widget_in_home_screen.dart';
import 'package:to_do_list/ui/search_screen/search_screen_bloc/search_screen_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchScreenBloc>(
      create: (context) {
        final searchScreenBloc = SearchScreenBloc(
          taskListRepository: taskListRepository,
        );
        searchScreenBloc.add(SearchScreenStarted(searchTerm: ''));
        return searchScreenBloc;
      },
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            shadowColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: Builder(
              builder: (context) {
                return TextField(
                  onChanged: (value) {
                    context.read<SearchScreenBloc>().add(
                      SearchScreenStarted(searchTerm: value),
                    );
                  },
                  onSubmitted: (value) {
                    context.read<SearchScreenBloc>().add(
                      SearchScreenStarted(searchTerm: value),
                    );
                  },
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Search your list',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.black,
                    ),
                    prefixIconColor: Colors.black,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xffE3E2E2),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: const Color(0xffF4F4F4),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                );
              }
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          body: BlocBuilder<SearchScreenBloc, SearchScreenState>(
            builder: (context, state) {
              if (state is SearchScreenSuccess) {
                return Padding(
                  padding: const EdgeInsets.only(top: 41,),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.taskLists.length,
                          itemBuilder: (context, index) {
                            final taskList = state.taskLists[index];
                            return TaskWidgetInHomeScreen(
                              taskList: taskList,
                              key: ValueKey(taskList.taskListID),
                              deleteTaskList: () {},

                              toggleTaskListExpansion: () {},
                              toggleTaskItemCompletion: (taskItemID) {},
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is SearchScreenError) {
                return AppErrorWidget(
                  exception: state.appException,
                  onPressed: () {},
                );
              } else if(state is SearchScreenLoading){
                return const Center(child: CircularProgressIndicator());
              }else {
                throw Exception();
              }
            },
          ),
        ),
      ),
    );
  }
}
