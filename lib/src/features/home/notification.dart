import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final BehaviorSubject<String?> onNotification =
      BehaviorSubject<String?>();

  static Future showNoti(
      {int id = 0, String? title, String? body, String? payload}) async {
    _notification.show(id, title, body, await _notificationDetails(), payload: payload);
  }

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails('chanel id', 'chanel name',
          importance: Importance.max),
    );
  }

  static Future init({bool initSchedule = false}) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final setting = InitializationSettings(android: android);

    await _notification.initialize(setting,
        onSelectNotification: (payload) async {
      onNotification.add(payload);
    });
  }
}
