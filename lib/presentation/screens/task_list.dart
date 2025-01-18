import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final db = FirebaseDatabase.instance;
  bool? checkbox = false;
  List<Map<dynamic, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    final dbRef = db.ref('tasks');

    dbRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final tasksData = event.snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          tasks =
              tasksData.entries.map((element) => element.value as Map<dynamic, dynamic>).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  child: Card(
                    child: ListTile(
                      // leading: Checkbox(
                      //   value: checkbox,
                      //   onChanged: (newValue) {
                      //     setState(() {
                      //       checkbox = newValue;
                      //     });
                      //   },
                      // ),

                      title: Text(
                        tasks[index]['title'],
                      ),
                      subtitle: Text(tasks[index]['body']),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
