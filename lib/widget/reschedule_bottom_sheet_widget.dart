import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tekyz_notification/constant/string_constant.dart';
import 'package:tekyz_notification/function/pick_time_func.dart';
import 'package:tekyz_notification/function/reschedule_notification_func.dart';
import 'package:tekyz_notification/utils/decoration.dart';

class RescheduleNotificationBottomSheetWidget extends StatelessWidget {
  final PendingNotificationRequest notification;
  const RescheduleNotificationBottomSheetWidget({
    super.key,
    required this.notification,
  });

  // Functions
  void openTimePickerFunc() async {
    final TimeOfDay? newPickedTime = await pickTime();
    if (newPickedTime != null) {
      rescheduleNotification(notification, newPickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Controllers
    final TextEditingController timeController = TextEditingController();

    return Container(
      margin: const EdgeInsets.all(20),
      child: Form(
        child: Column(
          children: [
            TextFormField(
              controller: timeController,
              readOnly: true,
              onTap: openTimePickerFunc,
              validator: (value) {
                if (value != null) {
                  return null;
                }
                return StringConst.selectValidTime;
              },
              decoration: inputDecorationWithOutline(
                label: StringConst.scheduleTime,
                suffix: IconButton(
                  onPressed: openTimePickerFunc,
                  icon: const Icon(Icons.date_range),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
