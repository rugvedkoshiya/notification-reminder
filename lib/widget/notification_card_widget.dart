import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tekyz_notification/constant/string_constant.dart';

class NotificationCardWidget extends StatelessWidget {
  final int index;
  final PendingNotificationRequest notification;
  final Function(String, PendingNotificationRequest) handleOption;

  const NotificationCardWidget({
    super.key,
    required this.index,
    required this.notification,
    required this.handleOption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                notification.title ?? "",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              PopupMenuButton(
                onSelected: (value) => handleOption(value, notification),
                itemBuilder: (context) {
                  return {StringConst.reschedule, StringConst.cancel}
                      .map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              )
            ],
          ),
          Text(
            notification.body ?? "",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
