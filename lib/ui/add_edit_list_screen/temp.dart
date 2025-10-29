// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:to_do_list/data/task_item_module.dart';
// import 'package:to_do_list/data/task_list_module.dart';
//
// class TaskListPageTemp extends StatefulWidget {
//   final TaskList taskList;
//   const TaskListPageTemp({super.key, required this.taskList});
//
//   @override
//   State<TaskListPageTemp> createState() => _TaskListPageTempState();
// }
//
// class _TaskListPageTempState extends State<TaskListPageTemp> {
//   final TextEditingController titleEditingController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     titleEditingController.text = 'Title';
//
//     for (var v in widget.taskList.taskListItems) {
//       final TaskItem taskItem = TaskItem(taskItemTitle: v.taskItemTitle);
//       taskItem.focusNode.addListener(() => handleFocusChange(taskItem));
//       widget.taskList.taskListItems.add(taskItem);
//     }
//   }
//
//   void handleFocusChange(TaskItem taskItem) {
//     if (!taskItem.focusNode.hasFocus) {
//       final text = taskItem.textEditingController.text.trim();
//       final taskItemIndex = widget.taskList.taskListItems.indexOf(taskItem);
//       if (taskItemIndex == -1) return;
//       if (text.isEmpty) {
//         setState(() {
//           widget.taskList.taskListItems.removeAt(taskItemIndex);
//         });
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           taskItem.focusNode.dispose();
//           taskItem.textEditingController.dispose();
//         });
//       } else {
//         setState(() {
//           taskItem.taskItemTitle = text;
//           taskItem.taskItemIsCompleted = false;
//         });
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     titleEditingController.dispose();
//     for (var task in widget.taskList.taskListItems) {
//       task.focusNode.dispose();
//       task.textEditingController.dispose();
//     }
//     super.dispose();
//   }
//
//   void addNewTask() {
//     setState(() {
//       final newTask = TaskItem(taskItemTitle: '', taskItemIsCompleted: true);
//       newTask.focusNode.addListener(() => handleFocusChange(newTask));
//       widget.taskList.taskListItems.add(newTask);
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (mounted) {
//           FocusScope.of(context).requestFocus(newTask.focusNode);
//         }
//       });
//     });
//   }
//
//   void togglePin() {
//     setState(() {
//       widget.taskList.taskListPinned = !widget.taskList.taskListPinned;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       behavior: HitTestBehavior.translucent,
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           surfaceTintColor: Colors.white,
//           backgroundColor: Colors.white,
//           elevation: 0,
//           shadowColor: Colors.transparent,
//           actionsPadding: EdgeInsets.only(right: 24),
//           actions: [
//             ElevatedButton(
//               onPressed: togglePin,
//               style: ButtonStyle(
//                 backgroundColor: WidgetStateProperty.resolveWith<Color?>((
//                     Set<WidgetState> states,
//                     ) {
//                   if (widget.taskList.taskListPinned) {
//                     return Colors.white;
//                   }
//                   return Colors.black;
//                 }),
//                 foregroundColor: WidgetStateProperty.resolveWith<Color?>((
//                     Set<WidgetState> states,
//                     ) {
//                   if (widget.taskList.taskListPinned) {
//                     return Colors.black;
//                   }
//                   return Colors.white;
//                 }),
//                 shape: WidgetStatePropertyAll(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(5)),
//                     side: BorderSide(width: 2, color: Colors.black),
//                   ),
//                 ),
//                 padding: WidgetStatePropertyAll(
//                   EdgeInsets.fromLTRB(8, 7, 8, 7),
//                 ),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Icon(CupertinoIcons.map_pin),
//                   Text(widget.taskList.taskListPinned ? 'Pin' : 'Pinned'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         body: Stack(
//           children: [
//             Positioned.fill(
//               bottom: 200,
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 24, right: 24),
//                     child: TextField(
//                       onTapOutside: (_) {
//                         final text = titleEditingController.text.trim();
//                         titleEditingController.text = text.isEmpty
//                             ? 'Title'
//                             : text;
//                         titleEditingController.selection =
//                             TextSelection.fromPosition(
//                               TextPosition(
//                                 offset: titleEditingController.text.length,
//                               ),
//                             );
//                       },
//                       onChanged: (value) {
//                         titleEditingController.text = value;
//                       },
//                       controller: titleEditingController,
//                       decoration: InputDecoration(border: InputBorder.none),
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 24,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: ReorderableListView.builder(
//                       proxyDecorator:
//                           (
//                           Widget child,
//                           int index,
//                           Animation<double> animation,
//                           ) {
//                         return AnimatedBuilder(
//                           animation: animation,
//                           builder: (context, _) {
//                             return Transform.scale(
//                               scale: 1.02,
//                               child: Material(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(10),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black26,
//                                         blurRadius: 12,
//                                         offset: Offset(0, 6),
//                                       ),
//                                     ],
//                                   ),
//                                   child: child,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: child,
//                         );
//                       },
//                       itemBuilder: (context, index) {
//                         if (index == widget.taskList.taskListItems.length) {
//                           return ListTile(
//                             key: ValueKey('add_task'),
//                             contentPadding: const EdgeInsets.only(
//                               left: 24,
//                               right: 24,
//                             ),
//                             leading: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(Icons.add, color: Colors.transparent),
//                                 Icon(Icons.add_box_outlined),
//                               ],
//                             ),
//                             title: Text('To-do'),
//                             onTap: addNewTask,
//                           );
//                         }
//                         final task = widget.taskList.taskListItems[index];
//                         return ListTile(
//                           key: ValueKey(task),
//                           contentPadding: const EdgeInsets.only(
//                             left: 24,
//                             right: 24,
//                           ),
//                           leading: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               ReorderableDragStartListener(
//                                 index: index,
//                                 child: Icon(Icons.drag_indicator),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     task.taskItemIsCompleted =
//                                     !task.taskItemIsCompleted;
//                                   });
//                                 },
//                                 child: Icon(
//                                   !task.taskItemIsCompleted
//                                       ? Icons.check_box_outline_blank
//                                       : Icons.check_box,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // le
//                           title: task.isEditing
//                               ? TextField(
//                             decoration: const InputDecoration(
//                               border: InputBorder.none,
//                               isDense: true,
//                             ),
//                             focusNode: task.focusNode,
//                             controller: task.textEditingController,
//                             autofocus: true,
//                             textInputAction: TextInputAction.done,
//                             onSubmitted: (value) {
//                               final text = value.trim();
//                               if (text.isNotEmpty) {
//                                 task.taskItemTitle = text;
//                                 task.isEditing = false;
//                                 addNewTask();
//                               } else {
//                                 FocusScope.of(context).unfocus();
//                               }
//                             },
//                           )
//                               : GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 task.isEditing = true;
//                               });
//                               WidgetsBinding.instance
//                                   .addPostFrameCallback((_) {
//                                 if (mounted) {
//                                   FocusScope.of(
//                                     context,
//                                   ).requestFocus(task.focusNode);
//                                   task
//                                       .textEditingController
//                                       .selection =
//                                       TextSelection.fromPosition(
//                                         TextPosition(
//                                           offset: task
//                                               .textEditingController
//                                               .text
//                                               .length,
//                                         ),
//                                       );
//                                 }
//                               });
//                             },
//                             child: Text(
//                               task.taskItemTitle,
//                               style: TextStyle(
//                                 decoration: task.taskItemIsCompleted
//                                     ? TextDecoration.lineThrough
//                                     : null,
//                               ),
//                             ),
//                           ),
//                           trailing: GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 widget.taskList.taskListItems.removeAt(index);
//                                 task.textEditingController.dispose();
//                                 task.focusNode.dispose();
//                               });
//                             },
//                             child: Icon(Icons.delete),
//                           ),
//                         );
//                       },
//                       itemCount: widget.taskList.taskListItems.length+2,
//                       onReorder: (oldIndex, newIndex) {
//                         setState(() {
//                           if (oldIndex < newIndex) {
//                             newIndex--;
//                           }
//                           if (newIndex >=
//                               widget.taskList.taskListItems.length) {
//                             newIndex = widget.taskList.taskListItems.length - 1;
//                           }
//                           final tempTask = widget.taskList.taskListItems
//                               .removeAt(oldIndex);
//                           widget.taskList.taskListItems.insert(
//                             newIndex,
//                             tempTask,
//                           );
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Positioned(
//             //   bottom: 0,
//             //   child: Container(
//             //     padding: EdgeInsets.fromLTRB(24, 0, 24, 48),
//             //     width: MediaQuery.of(context).size.width,
//             //     color: Colors.white,
//             //     child: Column(
//             //       crossAxisAlignment: CrossAxisAlignment.start,
//             //       mainAxisAlignment: MainAxisAlignment.spaceAround,
//             //       children: [
//             //         Divider(color: Color(0xffDADADA), thickness: 2),
//             //         SizedBox(height: 28),
//             //         Text(
//             //           'Choose a label',
//             //           style: TextStyle(
//             //             fontSize: 20,
//             //             fontWeight: FontWeight.w600,
//             //           ),
//             //         ),
//             //         SizedBox(height: 28),
//             //         Row(
//             //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //           children: [
//             //             LabelWidget(
//             //               label: 'Personal',
//             //               isSelected: labelEnum == LabelEnum.personal,
//             //               onTap: () {
//             //                 setState(() {
//             //                   labelEnum = LabelEnum.personal;
//             //                 });
//             //               },
//             //             ),
//             //             LabelWidget(
//             //               label: 'Work',
//             //               isSelected: labelEnum == LabelEnum.work,
//             //               onTap: () {
//             //                 setState(() {
//             //                   labelEnum = LabelEnum.work;
//             //                 });
//             //               },
//             //             ),
//             //             LabelWidget(
//             //               label: 'Finance',
//             //               isSelected: labelEnum == LabelEnum.finance,
//             //               onTap: () {
//             //                 setState(() {
//             //                   labelEnum = LabelEnum.finance;
//             //                 });
//             //               },
//             //             ),
//             //             LabelWidget(
//             //               label: 'Other',
//             //               isSelected: labelEnum == LabelEnum.other,
//             //               onTap: () {
//             //                 setState(() {
//             //                   labelEnum = LabelEnum.other;
//             //                 });
//             //               },
//             //             ),
//             //           ],
//             //         ),
//             //       ],
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class LabelWidget extends StatelessWidget {
//   final String label;
//   final bool isSelected;
//   final VoidCallback onTap;
//
//   const LabelWidget({
//     super.key,
//     required this.label,
//     required this.isSelected,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 26,
//         padding: EdgeInsets.only(left: 16, right: 16),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.black : Color(0xff898989),
//           borderRadius: BorderRadius.circular(6),
//         ),
//         child: Center(
//           child: Text(
//             label,
//             style: TextStyle(color: Colors.white, fontSize: 12),
//           ),
//         ),
//       ),
//     );
//   }
// }