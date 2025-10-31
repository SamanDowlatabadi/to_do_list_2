import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/ui/common/utils.dart';

import '../home_screen/home_screen_bloc/home_screen_bloc.dart';

class HomeScreenSlider extends StatelessWidget{
  final bool isPinned;
  const HomeScreenSlider({super.key, required this.isPinned});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomSlidingSegmentedControl(
        fixedWidth: MediaQuery.of(context).size.width / 2 - 24,
        initialValue: isPinned
            ? AllListPinnedEnum.pinned
            : AllListPinnedEnum.allList,
        innerPadding: EdgeInsets.zero,
        thumbDecoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        decoration: BoxDecoration(
          color: const Color(0xffE5E5E5),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 47,
        children: {
          AllListPinnedEnum.allList: Text(
            'All List',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isPinned
                  ? Colors.black.withAlpha(100)
                  : Colors.white,
            ),
          ),
          AllListPinnedEnum.pinned: Text(
            'Pinned',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isPinned
                  ? Colors.white
                  : Colors.black.withAlpha(100),
            ),
          ),
        },
        onValueChanged: (value) {
          context.read<HomeScreenBloc>().add(
            HomeScreenStarted(isPinned: !isPinned),
          );
        },
      ),
    );
  }

}