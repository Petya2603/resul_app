import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:todo_app/screns/home.dart';

void main() {
  runApp(const Todo_List());
}

// ignore: camel_case_types
class Todo_List extends StatefulWidget {
  const Todo_List({super.key});

  @override
  State<Todo_List> createState() => _Todo_ListState();
}

// ignore: camel_case_types
class _Todo_ListState extends State<Todo_List> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    const statusBarColor = Color.fromARGB(255, 74, 26, 172);
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: statusBarColor), // Set the status bar color
        child: HomeScreen(), // Your main app screen
      ),
    );
  }
}
