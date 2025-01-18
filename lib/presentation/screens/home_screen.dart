import 'package:flutter/material.dart';
import 'package:todo_list_app/presentation/screens/input_screen.dart';
import 'package:todo_list_app/presentation/screens/task_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade400,
      appBar: AppBar(
        title: Text(
          'Todo App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal.shade600,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => InputScreen()));
        },
        backgroundColor: Colors.teal.shade800,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: TaskList(),
    );
  }
}
