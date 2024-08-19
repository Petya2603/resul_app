import 'package:flutter/material.dart';

import 'package:todo_app/model/task.dart';
import 'package:get/get.dart';

class Todoitem extends StatefulWidget {
  final Task task;
 final Function(bool?) onChanged;
  Todoitem({
    super.key,
    required this.task,
    required this.onChanged,
  });
  @override
  State<Todoitem> createState() => _TodoitemState();
}
class _TodoitemState extends State<Todoitem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.task.isCompleted
          ? const Color.fromARGB(255, 40, 155, 5)
          : const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),

        leading: Checkbox(
          activeColor: const Color.fromARGB(255, 4, 0, 8),
          value: widget.task.isCompleted,
          onChanged: widget.onChanged,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.task.date,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  widget.task.time,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              widget.task.title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
