import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tekyz_notification/function/cancel_notification_func.dart';
import 'package:tekyz_notification/function/schedule_notification_func.dart';

Future<void> rescheduleNotification(
    PendingNotificationRequest notification, TimeOfDay time) async {
  await cancelNotification(notification.id);
  await scheduleNotification(
    title: notification.title,
    message: notification.body,
    time: time,
  );
}
