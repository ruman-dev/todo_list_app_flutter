import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/presentation/widgets/custom_input.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final db = FirebaseDatabase.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  void showSnackBar(BuildContext context, String title, String message, ContentType contentType) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Success',
            message: 'Task added successfully',
            contentType: ContentType.success,
            inMaterialBanner: true,
          ),
        ),
      );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> submitTask() async {
    final title = _titleController.text;
    final body = _bodyController.text;
    final now = DateTime.now();
    var currentDate = '${now.day}-${now.month}-${now.year}';
    // print('Title: $title, Body: $body, Date: $currentDate');
    if (title.isNotEmpty && body.isNotEmpty) {
      try {
        final dbRef = db.ref('tasks').push();
        await dbRef.set({
          'title': title,
          'body': body,
          'date': currentDate,
        });
        showSnackBar(context, 'Success', 'Task added successfully', ContentType.success);

        _titleController.clear();
        _bodyController.clear();
      } on Exception catch (e) {
        showSnackBar(context, 'Error', 'Failed to add task', ContentType.failure);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              CustomInput(label: 'Task Title', controller: _titleController),
              const SizedBox(height: 15),
              Expanded(
                child: CustomInput(label: 'Task Description', controller: _bodyController),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      submitTask();
                      // Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal.shade400),
                  child: const Text(
                    'Submit',
                    style:
                        TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
