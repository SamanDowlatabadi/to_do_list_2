import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final TextEditingController titleEditingController = TextEditingController();
  bool isPinned = false;
  final List<TaskItem> tasks = [];

  @override
  void initState() {
    super.initState();
    titleEditingController.text = 'Title';

    for (var v in taskTextList) {
      final TaskItem taskItem = TaskItem(text: v);
      tasks.add(taskItem);
    }
  }

  @override
  void dispose() {
    titleEditingController.dispose();
    for(var task in tasks){
      task.focusNode.dispose();
      task.textEditingController.dispose();
    }
    super.dispose();
  }

  void togglePin() {
    setState(() {
      isPinned = !isPinned;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          actionsPadding: EdgeInsets.only(right: 24),
          actions: [
            ElevatedButton(
              onPressed: togglePin,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color?>((
                  Set<WidgetState> states,
                ) {
                  if (isPinned) {
                    return Colors.white;
                  }
                  return Colors.black;
                }),
                foregroundColor: WidgetStateProperty.resolveWith<Color?>((
                  Set<WidgetState> states,
                ) {
                  if (isPinned) {
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
                  Text(isPinned ? 'Pin' : 'Pinned'),
                ],
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(
            children: [
              TextField(
                onTap: () {
                  titleEditingController.selection = TextSelection.fromPosition(
                    TextPosition(offset: titleEditingController.text.length),
                  );
                },
                onTapOutside: (_) {
                  final text = titleEditingController.text.trim();
                  titleEditingController.text = text.isEmpty ? 'Title' : text;
                  titleEditingController.selection = TextSelection.fromPosition(
                    TextPosition(offset: titleEditingController.text.length),
                  );
                },
                controller: titleEditingController,
                decoration: InputDecoration(border: InputBorder.none),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: tasks.length + 1,
                  itemBuilder: (context, index) {
                    if (index == tasks.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(),
                      );
                    }
                    final task = tasks[index];
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              task.done = !task.done;
                            });
                          },
                          child: Icon(
                            !task.done
                                ? Icons.square_outlined
                                : Icons.check_box,
                          ),
                        ),

                        Expanded(
                          child: TextField(
                                  controller: task.textEditingController,
                                ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List taskTextList = [
  'Stay hydrated',
  'Learn something new and useful',
  'Laugh more',
  "Make a meal at home",
  "Be active, if only for a few minutes",
];

class TaskItem {
  final String text;
  bool done;
  bool isEditing;
  final TextEditingController textEditingController;
  final FocusNode focusNode;

  TaskItem({required this.text, this.done = false, this.isEditing = false})
    : textEditingController = TextEditingController(text: text),
      focusNode = FocusNode();
}
