import 'package:flutter/material.dart';
import 'package:tekyz_notification/main.dart';

Future<TimeOfDay?> pickTime() async {
  TimeOfDay? newPickedTime = await showTimePicker(
    context: getContext,
    initialTime: TimeOfDay.now(),
  );
  return newPickedTime;
}
