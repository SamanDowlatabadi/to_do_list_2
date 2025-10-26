import 'package:flutter/material.dart';


class AllListEmptyStateColumn extends StatelessWidget {
  final VoidCallback newListFunc;
  const AllListEmptyStateColumn({super.key, required this.newListFunc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: FittedBox(
            child: Image.asset(
              'assets/images/home/dooit_empty_state_img.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Spacer(),
        Text(
          'Create your first to-do list...',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 31),
        ElevatedButton(
          onPressed: newListFunc,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.black),
            fixedSize: WidgetStatePropertyAll(Size(125, 45)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.add, color: Colors.white, size: 14,),
              Text('New List', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),),
            ],
          ),
        ),
        SizedBox(
          height: 200,
        )
      ],
    );
  }
}


class AllListPinnedEmptyStateColumn extends StatelessWidget {
  final VoidCallback newListFunc;
  const AllListPinnedEmptyStateColumn({super.key, required this.newListFunc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: FittedBox(
            child: Image.asset(
              'assets/images/home/dooit_empty_state_img_pinned.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Spacer(),
        Text(
          'Ooops! No pinned list yet...',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 31),
        ElevatedButton(
          onPressed: newListFunc,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.black),
            fixedSize: WidgetStatePropertyAll(Size(125, 45)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.add, color: Colors.white, size: 14,),
              Text('New List', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),),
            ],
          ),
        ),
        SizedBox(
          height: 200,
        )
      ],
    );
  }
}
