import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:one_clock/one_clock.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/screns/CompletedTasksScreen.dart';
import 'package:todo_app/screns/add_new_task.dart';
import 'package:todo_app/todo_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? date;
  String? time;
  String? description;
  bool isChecked = false;
  List<Task> todo = [];
  List<Task> completedTask = [];
  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void toggleTask(int index) async {
    setState(() {
      Task task = todo[index];
      task.isCompleted = !task.isCompleted;
      if (task.isCompleted) {
        completedTask.add(task);
        todo.removeAt(index);
      } else {
        todo.add(task);
        completedTask.remove(task);
      }
    });
    _saveTasks();
  }

  void addNewTask(Task newTask) async {
    setState(() {
      todo.add(newTask);
    });
    _saveTasks(); // Yeni görevi kaydet
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskJson = prefs.getString('tasks');
    if (taskJson != null) {
      final List<dynamic> tasksList = jsonDecode(taskJson);
      setState(() {
        todo = tasksList.map((task) => Task.fromJson(task)).toList();
      });
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskJson = jsonEncode(todo.map((task) => task.toJson()).toList());
    await prefs.setString('tasks', taskJson);
  }

  @override
  Widget build(BuildContext taskJson) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/header2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Row(
                  children: [
                    Expanded(
                      child: DigitalClock(
                          showSeconds: true,
                          isLive: true,
                          format: 'MMMEd',
                          textScaleFactor: 1.0,
                          digitalClockTextColor: Colors.white,
                          decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          datetime: DateTime.now()),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 90.0, top: 15.0),
                child: Text(
                  "Make your daily plan",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 245, 245, 242),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "My Tasks",
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Visibility(
                                  visible: todo.isEmpty,
                                  child: Lottie.asset('assets/2.json',
                                      width: 200, height: 200),
                                ),
                              ),
                              todo.isEmpty
                                  ? const Text(
                                      'Your task list is empty',
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
                                          itemCount: todo.length,
                                          itemBuilder: (context, index) {
                                            return Todoitem(
                                              task: todo[index],
                                              onChanged: (value) =>
                                                  toggleTask(index),
                                                  
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                            ],
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
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(
            left: 30.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton.extended(
                heroTag: "btn2",
                onPressed: () {
                  Get.to(
                    () => CompletedTasksScreen(
                      completedTasks: completedTask,
                    ),
                  );
                },
                label: const Text(' Completed '),
                backgroundColor: Colors.green,
              ),
              AddNewTask(
                addNewTask: addNewTask,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
