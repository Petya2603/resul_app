// ignore: unused_import
import 'dart:convert';

class Task {
  Task({
    required this.time,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.date,
  });

  final String time;
  final String title;
  final String description;
  bool isCompleted;
  final String date;


  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'date': date,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      time: json['time'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['isCompleted'] as bool,
      date: json['date'] as String,
    );
  }

  where(Function(dynamic t) param0) {}
}
