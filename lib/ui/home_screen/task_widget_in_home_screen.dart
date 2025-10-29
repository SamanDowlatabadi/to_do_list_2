import 'package:flutter/material.dart';
import 'package:to_do_list/data/task_list_module.dart';
import 'package:to_do_list/ui/add_edit_list_screen/add_edit_list_screen.dart';

class TaskWidgetInHomeScreen extends StatefulWidget {
  final TaskList taskList;
  final VoidCallback toggleTaskListExpansion;
  final Function(String) toggleTaskItemCompletion;

  const TaskWidgetInHomeScreen({
    super.key,
    required this.taskList,
    required this.toggleTaskItemCompletion,
    required this.toggleTaskListExpansion,
  });

  @override
  State<TaskWidgetInHomeScreen> createState() => _TaskWidgetInHomeScreenState();
}

class _TaskWidgetInHomeScreenState extends State<TaskWidgetInHomeScreen>
    with TickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    animationController.value = widget.taskList.taskListIsExpanded ? 1.0 : 0.0;
  }

  @override
  void didUpdateWidget(covariant TaskWidgetInHomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.taskList.taskListIsExpanded !=
        widget.taskList.taskListIsExpanded) {
      if (widget.taskList.taskListIsExpanded) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) =>
                AddEditListScreen(taskListID: widget.taskList.taskListID),
          ),
        );
      },
      onDoubleTap: widget.toggleTaskListExpansion,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Container(
            margin: const EdgeInsets.fromLTRB(24, 0, 24, 18),
            padding: const EdgeInsets.fromLTRB(22, 17, 22, 17),
            decoration: BoxDecoration(
              color: Color(widget.taskList.taskListBackgroundColor),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.taskList.taskListTitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizeTransition(
                  sizeFactor: animationController,
                  axisAlignment: -1.0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 14, bottom: 14),
                    child: Column(
                      children: widget.taskList.taskListItems.map((taskItem) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: GestureDetector(
                            onTap: () {
                              widget.toggleTaskItemCompletion(
                                taskItem.taskItemID,
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  taskItem.taskItemIsCompleted
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  taskItem.taskItemTitle,
                                  style: TextStyle(
                                    decoration: taskItem.taskItemIsCompleted
                                        ? TextDecoration.lineThrough
                                        : null,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 15,
                      padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        widget.taskList.taskListLabel
                            .toString()
                            .split('.')
                            .last,
                        style: const TextStyle(
                          fontSize: 8,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
