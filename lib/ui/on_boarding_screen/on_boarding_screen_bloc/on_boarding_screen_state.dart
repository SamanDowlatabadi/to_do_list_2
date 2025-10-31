part of 'on_boarding_screen_bloc.dart';

@immutable
sealed class OnBoardingScreenState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnBoardingScreenInitial extends OnBoardingScreenState {}

class OnBoardingScreenShow extends OnBoardingScreenState {}

class OnBoardingScreenNotShow extends OnBoardingScreenState {}
