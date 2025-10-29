import 'package:flutter/material.dart';
import 'package:to_do_list/common/exception.dart';

class AppErrorWidget extends StatelessWidget {
  final AppException exception;
  final VoidCallback onPressed;

  const AppErrorWidget({
    super.key,
    required this.exception,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(exception.message),
          ElevatedButton(
            onPressed: onPressed,
            child: const Text("تلاش دوباره"),
          ),
        ],
      ),
    );
  }
}
