import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  final bool isChecked;
  final String taskTitle;
  final Function(bool?)? checkboxCallback;
  final Function()? longPressCallback;

  const TaskTile({
    this.isChecked = false,
    required this.taskTitle,
    this.checkboxCallback,
    this.longPressCallback,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isChecked = false;

  @override
  void initState() {
    isChecked = widget.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      child: Dismissible(
        key: Key(widget.taskTitle),
        background: Container(
          padding: const EdgeInsets.only(right: 20.0),
          alignment: Alignment.centerRight,
          color: Colors.red,
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        onDismissed: (direction) {
          // for end to start swipe
          if (direction == DismissDirection.endToStart) {
            // Then show a snackbar.
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${widget.taskTitle} dismissed'),
              backgroundColor: Colors.red,
            ));
          }
          // Remove the item from the data source.
          // setState(() {
          //   items.removeAt(index);
          // });
          // Then show a snackbar.
        },
        child: ListTile(
          title: Text(
            widget.taskTitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              decoration: isChecked ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Checkbox(
            fillColor: const MaterialStatePropertyAll(Colors.purple),
            value: isChecked,
            onChanged: widget.checkboxCallback ??
                (_) {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
          ),
        ),
      ),
    );
  }
}
