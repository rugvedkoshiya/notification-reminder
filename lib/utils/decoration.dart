import 'package:flutter/material.dart';
import 'package:tekyz_notification/main.dart';

InputDecoration inputDecorationWithOutline({
  required String label,
  Widget? suffix,
}) =>
    InputDecoration(
      label: Text(label),
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.all(20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Theme.of(getContext).colorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Theme.of(getContext).colorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Theme.of(getContext).colorScheme.outline),
      ),
    );
