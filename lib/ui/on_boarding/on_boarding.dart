import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/ui/home_screen/home_screen.dart';
import 'package:to_do_list/ui/on_boarding/on_boarding_bloc/on_boarding_bloc.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingBloc()..add(OnBoardingIsFirstLaunch()),
      child: BlocBuilder<OnBoardingBloc, OnBoardingState>(
        builder: (context, state) {
          if(state is OnBoardingInitial){
            return SizedBox.shrink();
          }else if(state is  OnBoardingNotShow){
              return HomeScreen();
          }else if(state is OnBoardingShow){
            return Scaffold(
              backgroundColor: Colors.black,
              floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton.extended(
                backgroundColor: Colors.white,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                onPressed: () {
                  context.read<OnBoardingBloc>().add(OnBoardingCompleteButtonClicked());
                },
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 88),
                  child: Text(
                    'Continue',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/on_boarding/on_boarding_img.png',
                      height: 68,
                    ),
                    const SizedBox(height: 42),
                    Text(
                      'Dooit',
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'Write what you need to do. Everyday.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffC4C4C4),
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}

