import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:date_format/date_format.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_app/generated/l10n.dart' as i18n;
import 'package:todo_app/global/global.dart';
import 'package:todo_app/manager/todo_manager.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/page/todo_page.dart';
import 'package:todo_app/utils/navigator_utils.dart';

class NotificationManager {
  static final channelKey = 'local_channel';
  static final channelName = 'Local Notifications';

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static _format(int time) {
    return formatDate(
      DateTime.fromMillisecondsSinceEpoch(time),
      [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss, ' '],
    );
  }

  static initNotification() async {
    tz.initializeTimeZones();
    Future onSelectNotification(String? payload) async {
      try {
        var id = int.tryParse(payload ?? '');
        if (id == null) return;
        var context = Global.navigatorKey.currentContext;
        if (context == null) return;

        var todo = await TodoManager.query(id: id);
        NavigatorUtils.present(context, page: TodoPage(todo: todo));
      } catch (e) {}
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    var details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details?.didNotificationLaunchApp == true) {
      Future.delayed(Duration(seconds: 1)).then(
        (value) => onSelectNotification(details?.payload),
      );
    }
  }

  static Future createNotification({required Todo todo}) async {
    if (todo.isFinished) return;
    var context = Global.navigatorKey.currentContext;
    if (context == null) return;
    var android = new AndroidNotificationDetails(
      channelKey,
      channelName,
      'CHANNEL DESCRIPTION',
      priority: Priority.high,
      importance: Importance.max,
      onlyAlertOnce: true,
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);

    var scheduledDate =
        tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, todo.alarmTimeStamp)
            .add(Duration(minutes: -5));

    await flutterLocalNotificationsPlugin.zonedSchedule(
      todo.id,
      i18n.S.of(context).notification_title,
      todo.title,
      scheduledDate,
      platform,
      payload: '${todo.id}',
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future updateNotification({required Todo todo}) async {
    await cancelNotification(todo: todo);
    return createNotification(todo: todo);
  }

  static Future cancelNotification({required Todo todo}) async {
    return flutterLocalNotificationsPlugin.cancel(todo.id);
  }
}
