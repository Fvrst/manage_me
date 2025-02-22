import 'package:flutter/material.dart';
import 'package:manage_me/constant/colors.dart';
import 'package:manage_me/model/todo.dart';

class DetailsScreen extends StatefulWidget {
  final ToDo todo;
  final Function(ToDo) onSave;

  const DetailsScreen({super.key, required this.todo, required this.onSave});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late TextEditingController _todoController;

  @override
  void initState() {
    super.initState();
    _todoController = TextEditingController(text: widget.todo.todoText);
  }

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  void _saveTask() {
    widget.onSave(ToDo(
      id: widget.todo.id,
      todoText: _todoController.text,
      isDone: widget.todo.isDone,
    ));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        title: const Text("Task Details"),
        backgroundColor: tdBGColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: TextField(
                controller: _todoController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: "Task ",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: tdBlue),
              onPressed: _saveTask,
              child: const Text(
                "Done",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
