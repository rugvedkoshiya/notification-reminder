import 'package:flutter/material.dart';
import 'package:tekyz_notification/constant/string_constant.dart';

class NoNotificationWidget extends StatelessWidget {
  const NoNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        StringConst.noNotificationFound,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}
