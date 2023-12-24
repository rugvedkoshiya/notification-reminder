import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tekyz_notification/constant/string_constant.dart';
import 'package:tekyz_notification/function/configure_timezone_func.dart';
import 'package:tekyz_notification/function/pick_time_func.dart';
import 'package:tekyz_notification/function/schedule_notification_func.dart';
import 'package:tekyz_notification/utils/decoration.dart';
import 'package:tekyz_notification/utils/extension.dart';
import 'package:tekyz_notification/utils/show_toast.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  // Keys
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  // Variables
  int id = 0;
  TimeOfDay? pickedTime;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Functions

  void onSubmitFunc() async {
    try {
      if (_formKey.currentState?.validate() ?? false) {
        await scheduleNotification(
          title: titleController.text,
          message: messageController.text,
          time: pickedTime!,
        );
      }
    } catch (error) {
      showToast(message: error);
      // rethrow;
    }
  }

  void timeHandler() async {
    final TimeOfDay? newPickedTime = await pickTime();

    if (newPickedTime != null) {
      pickedTime = newPickedTime;
      timeController.text = pickedTime!.getReadableTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConst.addNotification),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: inputDecorationWithOutline(
                      label: StringConst.notificationTitle,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: messageController,
                    decoration: inputDecorationWithOutline(
                      label: StringConst.notificationMessage,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: timeController,
                    readOnly: true,
                    onTap: timeHandler,
                    validator: (value) {
                      if (value != null && pickedTime != null) {
                        return null;
                      }
                      return StringConst.selectValidTime;
                    },
                    decoration: inputDecorationWithOutline(
                      label: StringConst.scheduleTime,
                      suffix: IconButton(
                        onPressed: timeHandler,
                        icon: const Icon(Icons.date_range),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: onSubmitFunc,
                    child: const Text(StringConst.schedule),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
