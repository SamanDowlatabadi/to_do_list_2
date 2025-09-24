part of 'on_boarding_bloc.dart';

@immutable
sealed class OnBoardingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnBoardingIsFirstLaunch extends OnBoardingEvent {}

class OnBoardingCompleteButtonClicked extends OnBoardingEvent {}
