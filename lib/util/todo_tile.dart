import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;

  const ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: listtile(),
    );
  }

  Padding listtile() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15, top: 10, bottom: 10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              backgroundColor: Colors.red,
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Row(
            children: [
              // checkbox
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: Colors.green,
                  shape: const CircleBorder(),
                ),
              ),

              // task name
              Text(
                taskName,
                style: TextStyle(
                  decoration: taskCompleted
                      ? (TextDecoration.lineThrough)
                      : TextDecoration.none,
                  color: taskCompleted
                      ? Color.fromARGB(255, 0, 255, 0)
                      : Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
