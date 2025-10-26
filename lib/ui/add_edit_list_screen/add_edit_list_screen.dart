import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/data/task_list_module.dart';

class AddTaskScreen extends StatefulWidget {
  final TaskList taskList;
  const AddTaskScreen({super.key, required this.taskList});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        actionsPadding: EdgeInsets.only(right: 24),
        actions: [
          ElevatedButton(
            onPressed: (){
              setState(() {
                widget.taskList.taskListPinned = !widget.taskList.taskListPinned;
              });
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color?>((
                  Set<WidgetState> states,
                  ) {
                if (widget.taskList.taskListPinned) {
                  return Colors.white;
                }
                return Colors.black;
              }),
              foregroundColor: WidgetStateProperty.resolveWith<Color?>((
                  Set<WidgetState> states,
                  ) {
                if (widget.taskList.taskListPinned) {
                  return Colors.black;
                }
                return Colors.white;
              }),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  side: BorderSide(width: 2, color: Colors.black),
                ),
              ),
              padding: WidgetStatePropertyAll(
                EdgeInsets.fromLTRB(8, 7, 8, 7),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(CupertinoIcons.map_pin),
                Text(widget.taskList.taskListPinned ? 'Pin' : 'Pinned'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
