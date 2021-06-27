import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';

class TodoCell extends StatelessWidget {
  final Todo todo;
  final Function(Todo) onPressed;
  final Function(Todo, bool) onCheckboxChanged;
  const TodoCell({
    Key? key,
    required this.todo,
    required this.onPressed,
    required this.onCheckboxChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFinished = todo.isFinished;
    return InkWell(
      onTap: () => onPressed.call(todo),
      child: Container(
        height: 48,
        child: Row(
          children: [
            Checkbox(
              value: todo.isFinished,
              onChanged: (v) => onCheckboxChanged.call(todo, !(v ?? false)),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    todo.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: isFinished
                        ? TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                  Text(
                    todo.alarmTime,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
