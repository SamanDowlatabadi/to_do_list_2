part of 'search_screen_bloc.dart';

@immutable
sealed class SearchScreenEvent {}

class SearchScreenStarted extends SearchScreenEvent {
  final String searchTerm;

  SearchScreenStarted({required this.searchTerm});
}
