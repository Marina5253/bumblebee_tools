import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoElement extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final String taskText;
  final String taskDate;
  Function(bool?)? completeTodo;
  Function(BuildContext)? deleteTodo;
  Function() editTodo;

  TodoElement(
      {super.key,
      required this.taskName,
      required this.taskCompleted,
      required this.completeTodo,
      required this.taskText,
      required this.taskDate,
      required this.deleteTodo,
      required this.editTodo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteTodo,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(20),
              backgroundColor: Theme.of(context).colorScheme.secondary,
            )
          ],
        ),
        child: GestureDetector(
          onLongPress: editTodo,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: taskCompleted,
                      onChanged: completeTodo,
                      activeColor: Theme.of(context).colorScheme.tertiary,
                    ),
                    Expanded(
                      child: Text(
                        taskName,
                        maxLines: 4,
                        textScaler: const TextScaler.linear(1.5),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(
                            decoration: taskCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    taskText,
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      taskDate,
                      maxLines: 1,
                      textScaler: const TextScaler.linear(0.8),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
