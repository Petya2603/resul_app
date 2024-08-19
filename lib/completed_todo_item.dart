import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';
import 'package:get/get.dart';

class CompletedTodoitem extends StatefulWidget {
  final Task completedTasks;

  final onDeleteItem;

  CompletedTodoitem({
    super.key,
    required this.completedTasks,
    required this.onDeleteItem,
  });

  @override
  State<CompletedTodoitem> createState() => TodoitemState();
}

class TodoitemState extends State<CompletedTodoitem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.completedTasks.date,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  widget.completedTasks.time,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              widget.completedTasks.title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          iconSize: 24,
          icon: const Icon(Icons.delete),
          onPressed: widget.onDeleteItem,
        ),
      ),
    );
  }
}
