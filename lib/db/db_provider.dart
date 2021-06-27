import 'package:sqflite/sqflite.dart';
import 'package:todo_app/db/db_manager.dart';

abstract class DBProvider {
  Future<Database> get database => DBManager.instance.database;

  String get tableName;

  String get columId;

  String get tableSQL;
}
