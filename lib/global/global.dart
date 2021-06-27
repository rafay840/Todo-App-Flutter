import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/db/db_manager.dart';
import 'package:todo_app/manager/file_manager.dart';
import 'package:todo_app/manager/notification_manager.dart';

class Global {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      await FileManager.initDir();
    } catch (e) {
      debugPrint(' init dir error: $e');
    }

    try {
      await DBManager.instance.initDB();
    } catch (e) {
      debugPrint(' init db error: $e');
    }

    NotificationManager.initNotification();
  }
}
