import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  SharedPreferenceHelper._();
  static SharedPreferenceHelper instance = SharedPreferenceHelper._();

  // Keys
  static const String notificationIdKey = "notification_id";

  // Variables
  int notificationId = 0;
  late SharedPreferences _prefs;

  Future<void> loadInitial() async {
    _prefs = await SharedPreferences.getInstance();
    _fetchNotificationId();
  }

  // Getters OR Fetching
  void _fetchNotificationId() {
    int? retrievedNotificationId = _prefs.getInt(notificationIdKey);
    if (retrievedNotificationId != null) {
      notificationId = retrievedNotificationId;
    }
  }

  // Setters
  Future<int> updateId() async {
    await _prefs.setInt(notificationIdKey, ++notificationId);
    return notificationId;
  }
}
