import 'package:tekyz_notification/main.dart';

Future<void> cancelNotification(int notificationId) async {
  await flutterLocalNotificationsPlugin.cancel(notificationId);
}