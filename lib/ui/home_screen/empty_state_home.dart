import 'package:flutter/material.dart';


class EmptyStateWidget extends StatelessWidget {
  final VoidCallback newListFunc;
  final bool isPinned;
  const EmptyStateWidget({super.key, required this.newListFunc, required this.isPinned});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       !isPinned? SizedBox(
          width: double.infinity,
          child: FittedBox(
            child: Image.asset(
             'assets/images/home/dooit_empty_state_img.png',
              fit: BoxFit.cover,
            ),
          ),
        ):SizedBox(
         child: FittedBox(
           child: Image.asset(
             'assets/images/home/dooit_empty_state_img_pinned.png',
             fit: BoxFit.fill,
           ),
         ),
       ),
        const Spacer(),
        Text(
         !isPinned? 'Create your first to-do list...' : 'Ooops! No pinned list yet...',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 31),
        ElevatedButton(
          onPressed: newListFunc,
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(Colors.black),
            fixedSize: const WidgetStatePropertyAll(Size(125, 45)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.add, color: Colors.white, size: 14,),
              Text('New List', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),),
            ],
          ),
        ),
        const SizedBox(
          height: 200,
        )
      ],
    );
  }
}
