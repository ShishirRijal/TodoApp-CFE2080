import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';

class TaskTile extends StatefulWidget {
  final TodoModel todo;

  const TaskTile({
    super.key,
    required this.todo,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child: Dismissible(
        key: Key(widget.todo.id),
        background: Container(
          padding: const EdgeInsets.only(right: 20.0),
          alignment: Alignment.centerRight,
          color: Colors.red,
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        onDismissed: (direction) {
          // for end to start swipe
          if (direction == DismissDirection.endToStart) {
            TodoModel.deleteTask(widget.todo);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${widget.todo.title} dismissed'),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: ListTile(
          title: Text(
            widget.todo.title,
            style: TextStyle(
              fontSize: 18,
              // fontWeight: FontWeight.w500,
              decoration:
                  widget.todo.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Checkbox(
            side: const BorderSide(width: 0),
            fillColor: const MaterialStatePropertyAll(Colors.purple),
            value: widget.todo.isCompleted,
            onChanged: (_) {
              TodoModel todo = widget.todo;
              todo.toggleCompleted();
              TodoModel.updateTask(todo);
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
