import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/model/task.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key, required this.addNewTask});
  final void Function(Task newTask) addNewTask;
  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  DateFormat formatter = DateFormat('dd.MM');
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: "btn1",
      onPressed: () {
        showModalBottomSheet<void>(
          enableDrag: false,
          isDismissible: false,
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 60, left: 30.0, right: 30.0),
                      child: Expanded(
                        child: TextFormField(
                          controller: titleController,
                          decoration: InputDecoration(
                              labelText: "Task Title",
                              labelStyle: const TextStyle(
                                color: Colors.green,
                                fontFamily: 'Raleway',
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Colors.green,
                                  width: 2.0,
                                ),
                              ),
                              fillColor: Colors.green),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Task title cannot be empty';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 30.0, right: 30.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              readOnly: true,
                              controller: dateController,
                              decoration: InputDecoration(
                                  suffixIcon: const Icon(
                                    Icons.calendar_month,
                                    color: Colors.green,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  labelText: "Set Date",
                                  labelStyle: const TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 16,
                                      color: Colors.green)),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                if (pickedDate != null) {
                                  dateController.text =
                                      pickedDate.toString().split(' ').first;
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 40.0,
                          ),
                          Expanded(
                            child: TextField(
                              readOnly: true,
                              controller: timeController,
                              decoration: InputDecoration(
                                  suffixIcon: const Icon(
                                    Icons.alarm,
                                    color: Colors.green,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  labelText: "Set Time",
                                  labelStyle: const TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 16,
                                      color: Colors.green)),
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );

                                if (pickedTime != null) {
                                  final formattedTime =
                                      pickedTime.format(context);
                                  timeController.text = formattedTime;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: descriptionController,
                                maxLines: 5,
                                decoration: InputDecoration(
                                    labelText: " Description ",
                                    labelStyle: const TextStyle(
                                      color: Colors.green,
                                      fontFamily: 'Raleway',
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        color: Colors.green,
                                        width: 2.0,
                                      ),
                                    ),
                                    fillColor: Colors.green),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Description cannot be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              backgroundColor: HexColor('008000'),
                              minimumSize: const Size(100, 50),
                            ),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Task newTask = Task(
                                  title: titleController.text,
                                  date: dateController.text,
                                  time: timeController.text,
                                  description: descriptionController.text,
                                );
                                titleController.text = '';
                                timeController.text = '';
                                dateController.text = '';
                                descriptionController.text = '';
                                widget.addNewTask(newTask);
                                Navigator.of(context).pop();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor('008000'),
                                minimumSize: const Size(100, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            child: const Text(
                              "  Save  ",
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      label: const Text('New task'),
      icon: const Icon(Icons.add),
      backgroundColor: Colors.green,
    );
  }
}
