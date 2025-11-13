import 'package:quick_cars_service/barrel.dart';


void customToast({required String msg, required var color, int? time}) =>
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: time ?? 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0.sp,
    );
