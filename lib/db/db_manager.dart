import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/todo_dao.dart';

import 'db_provider.dart';

class DBManager {
  factory DBManager() => _sharedInstance();

  static DBManager? _instance;

  static DBManager get instance => _sharedInstance();

  DBManager._();

  static DBManager _sharedInstance() {
    if (_instance == null) {
      _instance = DBManager._();
    }
    return _instance!;
  }

  late Future<Database> database;
  List<DBProvider> tables = [TodoDAO()];

  initDB() async {
    try {
      Directory documentsDir = await getApplicationDocumentsDirectory();
      Directory imDir = Directory(p.join(documentsDir.path, 'todo'));
      if (imDir.existsSync()) imDir.createSync();
      debugPrint('$imDir');
      database = openDatabase(
        p.join(imDir.path, 'todo_database.db'),
        onCreate: (db, version) {
          try {
            Batch batch = db.batch();
            _createTable().forEach((element) {
              batch.execute(element);
            });
            batch.commit();
          } catch (err) {
            debugPrint('>>> $err');
            throw (err);
          }
        },
        onUpgrade: (Database db, int oldVersion, int newVersion) {
          try {
            Batch batch = db.batch();
            _createTable().forEach((element) {
              batch.execute(element);
            });
            batch.commit();
          } catch (err) {
            throw (err);
          }
        },
        // 数据库版本
        version: 1,
      );
    } catch (err, stack) {
      debugPrint('$err\n$stack');
      throw (err);
    }
  }

  closeDB() async {
    await database
      ..close();
  }

  List<String> _createTable() {
    return tables.map((e) => e.tableSQL).toList();
  }
}
