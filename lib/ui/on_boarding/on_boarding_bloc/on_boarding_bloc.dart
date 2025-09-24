import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'on_boarding_event.dart';

part 'on_boarding_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  OnBoardingBloc() : super(OnBoardingInitial()) {
    on<OnBoardingIsFirstLaunch>((event, emit) async {

      final prefs = await SharedPreferences.getInstance();
      final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

      if (isFirstLaunch) {
        emit(OnBoardingShow());
      } else {
        if(prefs.getBool('isFirstLaunch') != null) {
          emit(OnBoardingNotShow());
        }
      }
    });

    on<OnBoardingCompleteButtonClicked>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFirstLaunch', false);
      emit(OnBoardingNotShow());
    });
  }
}
