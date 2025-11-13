import 'package:quick_cars_service/barrel.dart';

class AppColors {
  static const primaryColor = Color(0xff113861);
  static const secondaryColor = Color(0xfffdfdfe);

  static Color greyColor = const Color(0xff858585);
  static Color textFormFiedlColor = const Color(0xffD9D9D9).withAlpha(77);
  static const contierIconColoor = Color(0xffD2EBE7);

  static const scaffoldBackground = Color(0xFFFFFFFF);
  static const bottomNavLightThemeBackground = Color.fromARGB(
    255,
    212,
    212,
    212,
  );
  static const textColor = Colors.black;

  static const successColor = Color.fromARGB(255, 12, 121, 70);
  static const errorColor = Color(0xFFEF2828);
}

class Myshadow {
  static var shadow = BoxShadow(
    color: AppColors.greyColor.withAlpha(51),
    spreadRadius: 1,
    blurRadius: 6,
    offset: const Offset(0, 2),
  );
}

List<dynamic> color = [
  const Color(0xffffedb4),
  const Color(0xffffeacc),
  const Color(0xfffff3da),
];

const fontFamily = 'Almarai';
