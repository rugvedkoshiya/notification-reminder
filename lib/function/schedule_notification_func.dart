import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tekyz_notification/constant/string_constant.dart';
import 'package:tekyz_notification/main.dart';
import 'package:tekyz_notification/model/notification_model.dart';
import 'package:tekyz_notification/utils/shared_preference_helper.dart';
import 'package:tekyz_notification/utils/show_toast.dart';
import 'package:timezone/timezone.dart' as tz;

Future<void> scheduleNotification({
  required String? title,
  required String? message,
  required TimeOfDay time,
}) async {
  try {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'test-channel',
      'test-channel',
      channelDescription: 'This is test channel for local notification testing',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      categoryIdentifier: "test-category",
    );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    final DateTime currDateTime = DateTime.now();
    final DateTime scheduledDateTime = DateTime(
      currDateTime.year,
      currDateTime.month,
      currDateTime.day,
      time.hour,
      time.minute,
    );

    final tz.TZDateTime scheduledTZDateTime = tz.TZDateTime.from(
      scheduledDateTime,
      tz.local,
    );

    int newNotificationId = await SharedPreferenceHelper.instance.updateId();

    var notificationModal = NotificationModal(
      notificationId: newNotificationId,
      title: title,
      body: message,
      dateTime: scheduledTZDateTime,
    );
    // await notificationBox.put(notificationModal.notificationId, notificationModal);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      newNotificationId,
      notificationModal.title,
      notificationModal.body,
      notificationModal.dateTime,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    showToast(message: StringConst.scheduledSuccessfully);
    // ignore: use_build_context_synchronously
    Navigator.of(getContext).pop();
  } catch (e) {
    showToast(message: StringConst.selectValidTime);
  }
}
