import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  String get getReadableTime =>
      "${hour.toString().padLeft(2, '0')} : ${minute.toString().padLeft(2, '0')} ${period.name.toUpperCase()}";
}
