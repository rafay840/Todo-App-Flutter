import 'package:flutter/material.dart';
import 'package:todo_app/manager/notification_manager.dart';
import 'package:todo_app/model/todo_dao.dart';
import 'package:todo_app/model/todo.dart';

class TodoManager {
  static Future<List<Todo>> list({
    int page = 1,
    int pageSize = 20,
  }) async {
    return TodoDAO().list(page: page, pageSize: pageSize);
  }

  static Future<Todo> query({required int id}) async {
    return TodoDAO().todo(id: id);
  }

  static Future add(Todo todo) async {
    todo.updateTimeStamp = DateTime.now().millisecondsSinceEpoch;
    var id = await TodoDAO().insert(todo: todo);
    todo.id = id;

    await NotificationManager.createNotification(todo: todo);
    return id;
  }

  static Future update(Todo todo, {bool isUpdateTime = false}) async {
    todo.updateTimeStamp = DateTime.now().millisecondsSinceEpoch;
    var result = await TodoDAO().update(todo: todo);

    if (isUpdateTime) {
      await NotificationManager.updateNotification(todo: todo);
    }

    return result;
  }

  static Future delete(Todo todo) async {
    try {
      await todo.deleteImage(justDeleteImage: true);
    } catch (e) {
      debugPrint('delete image error: $e');
    }
    var result = await TodoDAO().delete(id: todo.id);

    await NotificationManager.cancelNotification(todo: todo);
    return result;
  }
}
