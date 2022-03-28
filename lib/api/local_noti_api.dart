// ignore_for_file: prefer_const_constructors

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();

  static NotificationDetails _notificationDetail() {
    // final styleInformation = BigPictureStyleInformation(
    //   FilePathAndroidBitmap(bigpicpath),
    //   largeIcon: FilePathAndroidBitmap
    // );
    return NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id', 'channel name',
          importance: Importance.max,
          priority: Priority.high,
//styleInformation: styleInformation
//
        ),
        iOS: IOSNotificationDetails());
  }

  static Future init({bool initSchedule = false}) async {
    final ios = IOSInitializationSettings();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings = InitializationSettings(android: android, iOS: ios);
    await _notification.initialize(settings,
        onSelectNotification: (payload) async {
      onNotification.add(payload);
    });
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? payload,
    String? body,
  }) async {
    _notification.show(
      id,
      title,
      body,
      NotificationApi._notificationDetail(),
      payload: payload,
    );
  }

  static Future showScheduleNotification({
    int id = 1,
    String? title,
    String? payload,
    String? body,
    required DateTime scheduledDate,
  }) async {
    _notification.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        NotificationApi._notificationDetail(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
