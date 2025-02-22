import 'package:flutter/material.dart';
import 'package:manage_me/model/todo.dart';
import 'package:manage_me/screens/detail_screen.dart';
import '../constant/colors.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  final Function(ToDo) onToDoChanged;
  final Function(String) onDeleteItem;
  final Function(ToDo) onEditItem;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
    required this.onEditItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (value) {
            onToDoChanged(ToDo(
              id: todo.id,
              todoText: todo.todoText,
              isDone: value ?? false,
            ));
          },
          activeColor: tdBlue,
        ),
        title: Text(
          todo.todoText,
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(
                todo: todo,
                onSave: onEditItem,
              ),
            ),
          );
        },
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => onDeleteItem(todo.id),
        ),
      ),
    );
  }
}
