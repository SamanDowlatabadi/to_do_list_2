import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/ui/add_edit_list_screen/add_edit_list_screen.dart';
import 'package:to_do_list/ui/common/utils.dart';
import 'package:to_do_list/ui/home_screen/empty_state_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AllListPinnedEnum allPinned = AllListPinnedEnum.allList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 21),
        actions: [Icon(Icons.search, size: 27)],
        titleSpacing: 21,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/app_bar/app_bar_dooit_logo.png'),
            SizedBox(width: 12),
            Text('Dooit'),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 41),
          Center(
            child: CustomSlidingSegmentedControl(
              fixedWidth: MediaQuery.of(context).size.width / 2 - 48,
              initialValue: AllListPinnedEnum.allList,
              innerPadding: EdgeInsets.zero,
              thumbDecoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              decoration: BoxDecoration(
                color: Color(0xffE5E5E5),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 47,
              children: {
                AllListPinnedEnum.allList: Text(
                  'All List',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: allPinned == AllListPinnedEnum.allList
                        ? Colors.white
                        : Colors.black.withValues(alpha: 0.4),
                  ),
                ),
                AllListPinnedEnum.pinned: Text(
                  'Pinned',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: allPinned == AllListPinnedEnum.allList
                        ? Colors.black.withValues(alpha: 0.4)
                        : Colors.white,
                  ),
                ),
              },
              onValueChanged: (value) {
                setState(() {
                  allPinned = value;
                });
              },
            ),
          ),
          SizedBox(height: 112.5),
          allPinned == AllListPinnedEnum.allList
              ? Expanded(
                  child: AllListEmptyStateColumn(
                    newListFunc: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => TaskListPage()),
                      );
                    },
                  ),
                )
              : Expanded(child: AllListPinnedEmptyStateColumn()),
        ],
      ),
    );
  }
}
