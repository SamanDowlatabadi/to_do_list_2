part of 'on_boarding_screen_bloc.dart';

@immutable
sealed class OnBoardingScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnBoardingScreenIsFirstLaunch extends OnBoardingScreenEvent {}

class OnBoardingScreenCompleteButtonClicked extends OnBoardingScreenEvent {}
