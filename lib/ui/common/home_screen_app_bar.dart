import 'package:flutter/material.dart';
import 'package:to_do_list/ui/search_screen/search_screen.dart';

AppBar homeScreenAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    shadowColor: Colors.transparent,
    actionsPadding: const EdgeInsets.only(right: 21),
    actions: [
      IconButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const SearchScreen()));
        },
        icon: const Icon(Icons.search, size: 27),
      ),
    ],
    titleSpacing: 21,
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/app_bar/app_bar_dooit_logo.png'),
        const SizedBox(width: 12),
        const Text('Dooit'),
      ],
    ),
  );
}
