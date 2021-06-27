import 'package:flutter/material.dart';
import 'package:todo_app/db/db_provider.dart';

import 'todo.dart';

class TodoDAO with DBProvider {
  @override
  String get tableName => '_todo';
  String get columId => '_id';

  @override
  String get tableSQL => '''
      CREATE TABLE $tableName (
        $columId INTEGER PRIMARY KEY AUTOINCREMENT,
        title text,
        content text,
        image text,
        alarm_time integer,
        deleted_time integer,
        finished_time integer,
        update_time integer,
        create_time integer)
      ''';

  Future<List<Todo>> list({int page = 1, int pageSize = 20}) async {
    var db = await database;
    var list = await db.query(
      tableName,
      orderBy: 'alarm_time DESC',
      // where: 'deleted_time != ?',
      // whereArgs: [0],
      offset: (page - 1) * pageSize,
      limit: pageSize,
    );
    return list.map((e) => Todo.fromJson(e)).toList();
  }

  Future<Todo> todo({required int id}) async {
    var db = await database;
    var list = await db.query(
      tableName,
      where: '$columId=?',
      whereArgs: [id],
    );
    var result = list.map((e) => Todo.fromJson(e)).toList();
    if (result.isEmpty) throw 'todo is null';
    return result[0];
  }

  Future insert({required Todo todo}) async {
    var db = await database;
    var data = todo.toJson();
    data.remove(columId);
    debugPrint('insert: $data');
    return db.insert(tableName, data);
  }

  Future delete({required int id}) async {
    var db = await database;
    return db.delete(
      tableName,
      where: '$columId=?',
      whereArgs: [id],
    );
  }

  Future update({required Todo todo}) async {
    var db = await database;
    var data = todo.toJson();
    data.remove(columId);
    debugPrint('$data');
    return db.update(
      tableName,
      data,
      where: '$columId=?',
      whereArgs: [todo.id],
    );
  }
}
