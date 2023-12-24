import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tekyz_notification/constant/string_constant.dart';
import 'package:tekyz_notification/function/cancel_notification_func.dart';
import 'package:tekyz_notification/screen/timer_screen.dart';
import 'package:tekyz_notification/widget/notification_card_widget.dart';
import 'package:tekyz_notification/widget/reschedule_bottom_sheet_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  // Variables
  int id = 0;
  TimeOfDay? pickedTime;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // List<ActiveNotification> activeNotifications = [];
  List<PendingNotificationRequest> pendingNotifications = [];

  // Functions
  Future<void> _getNotification() async {
    // activeNotifications =
    //     await flutterLocalNotificationsPlugin.getActiveNotifications();
    pendingNotifications =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();

    setState(() {});
  }

  Future<void> handleOptionFunc(
    String value,
    PendingNotificationRequest notification,
  ) async {
    if (value == StringConst.reschedule) {
      // Reschedule notification
      await showModalBottomSheet(
        context: context,
        useSafeArea: true,
        showDragHandle: true,
        builder: (context) => RescheduleNotificationBottomSheetWidget(
          notification: notification,
        ),
      );
    } else if (value == StringConst.cancel) {
      // Cancel notification
      await cancelNotification(notification.id);
    }
    await _getNotification();
  }

  @override
  void initState() {
    _getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConst.tekyzNotification),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (ctx) => const TimerScreen(),
            ),
          )
              .then((value) {
            _getNotification();
          });
        },
        child: const Icon(
          Icons.add_rounded,
        ),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: _getNotification,
        child: SafeArea(
          bottom: false,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.separated(
              itemCount: pendingNotifications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) => NotificationCardWidget(
                index: index,
                notification: pendingNotifications[index],
                handleOption: handleOptionFunc,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
