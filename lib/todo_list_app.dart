import 'package:flutter/material.dart';
import 'package:todo_list_app/presentation/screens/home_screen.dart';

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List App',
      color: Colors.black54,
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
