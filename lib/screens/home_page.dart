import 'package:flutter/material.dart';
import 'package:manage_me/model/todo.dart';
import 'package:manage_me/screens/detail_screen.dart';
import '../constant/colors.dart';
import '../widgets/todo_item.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<ToDo> todosList = ToDo.todoList();
  final TextEditingController _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        backgroundColor: tdBGColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.menu, color: tdBlack, size: 30),
            Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/avatar.png'),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  'All ToDos',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                for (ToDo todo in todosList)
                  TodoItem(
                    todo: todo,
                    onToDoChanged: _handleToDoChange,
                    onDeleteItem: _deleteToDoItem,
                    onEditItem: _editToDoItem,
                  ),
              ],
            ),
          ),
          _buildAddTaskBar(),
        ],
      ),
    );
  }

  Widget _buildAddTaskBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _todoController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: 'Add a new todo item',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: tdBlue),
            onPressed: _addToDoItem,
            child: const Text("+",
                style: TextStyle(fontSize: 30, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo updatedTodo) {
    setState(() {
      int index = todosList.indexWhere((todo) => todo.id == updatedTodo.id);
      if (index != -1) {
        todosList[index] = updatedTodo;
      }
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem() {
    if (_todoController.text.isEmpty) return;

    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: _todoController.text,
      ));
    });

    _todoController.clear();
  }

  void _editToDoItem(ToDo updatedTodo) {
    setState(() {
      int index = todosList.indexWhere((todo) => todo.id == updatedTodo.id);
      if (index != -1) {
        todosList[index] = updatedTodo;
      }
    });
  }
}
