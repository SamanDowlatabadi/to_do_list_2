import 'package:equatable/equatable.dart';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'on_boarding_screen_event.dart';

part 'on_boarding_screen_state.dart';

class OnBoardingScreenBloc extends Bloc<OnBoardingScreenEvent, OnBoardingScreenState> {
  OnBoardingScreenBloc() : super(OnBoardingScreenInitial()) {
    on<OnBoardingScreenIsFirstLaunch>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

      if (isFirstLaunch) {
        emit(OnBoardingScreenShow());
      } else {
        if (prefs.getBool('isFirstLaunch') != null) {
          emit(OnBoardingScreenNotShow());
        }
      }
    });

    on<OnBoardingScreenCompleteButtonClicked>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFirstLaunch', false);
      emit(OnBoardingScreenNotShow());
    });
  }
}
