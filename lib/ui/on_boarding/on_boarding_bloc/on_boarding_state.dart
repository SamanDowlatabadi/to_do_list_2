part of 'on_boarding_bloc.dart';

@immutable
sealed class OnBoardingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnBoardingInitial extends OnBoardingState {}

class OnBoardingShow extends OnBoardingState {}

class OnBoardingNotShow extends OnBoardingState {
  OnBoardingNotShow();
}
