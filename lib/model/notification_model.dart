import 'package:timezone/timezone.dart' as tz;

class NotificationModal {
  final int notificationId;
  final String? title;
  final String? body;
  final tz.TZDateTime dateTime;

  NotificationModal({
    required this.notificationId,
    required this.title,
    required this.body,
    required this.dateTime,
  });
}
