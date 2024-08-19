import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/completed_todo_item.dart';
import 'package:todo_app/model/task.dart';

class CompletedTasksScreen extends StatefulWidget {
  final List<Task> completedTasks;
  CompletedTasksScreen({required this.completedTasks});

  @override
  State<CompletedTasksScreen> createState() => CompletedTasksScreenState();
}

class CompletedTasksScreenState extends State<CompletedTasksScreen> {
  void deleteTask(Task task) {
    setState(() {
      widget.completedTasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: const Text(
            "My completed tasks",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 245, 245, 242),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Visibility(
                            visible: widget.completedTasks.isEmpty,
                            child: Lottie.asset("assets/2.json",
                                width: 200, height: 200),
                          ),
                        ),
                      ),
                      widget.completedTasks.isEmpty
                          ? const Text(
                              'Completed task list is empty',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black45,
                              ),
                            )
                          : Expanded(
                              child: SingleChildScrollView(
                                child: ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: widget.completedTasks.length,
                                  itemBuilder: (context, index) {
                                    final task = widget.completedTasks[index];
                                    return CompletedTodoitem(
                                      completedTasks: task,
                                      onDeleteItem: () => deleteTask(task),
                                    );
                                  },
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
