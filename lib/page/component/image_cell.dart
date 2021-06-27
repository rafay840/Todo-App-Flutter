import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/model/todo.dart';

class ImageCell extends StatelessWidget {
  final Todo todo;
  final Function(Todo) onPressed;
  final Function(String) onImagePressed;
  final Function(Todo) onDeletePressed;
  ImageCell({
    Key? key,
    required this.todo,
    required this.onPressed,
    required this.onImagePressed,
    required this.onDeletePressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isImgExist = (todo.imagePath != null && todo.imagePath != '');
    return InkWell(
      onTap: () => onPressed.call(todo),
      child: Container(
        height: 66,
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: !isImgExist
                      ? null
                      : () => onImagePressed.call(todo.imagePath!),
                  child: isImgExist
                      ? Hero(
                          tag: 'image',
                          child: Image.file(File(todo.imagePath!), height: 60),
                        )
                      : Text(S.of(context).select_image),
                ),
              ),
            ),
            if (isImgExist)
              IconButton(
                onPressed: () => onDeletePressed.call(todo),
                icon: Icon(Icons.delete),
              )
          ],
        ),
      ),
    );
  }
}
