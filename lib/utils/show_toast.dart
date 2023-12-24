import 'package:fluttertoast/fluttertoast.dart';

void showToast({required dynamic message}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR);
}
