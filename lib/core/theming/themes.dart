import 'package:quick_cars_service/barrel.dart';

final ThemeData lightTheme = ThemeData(
  fontFamily: fontFamily,
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.primaryColor,
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    elevation: 0,
    scrolledUnderElevation: 0,
    titleTextStyle: TextStyle(
      color: AppColors.primaryColor,
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
      fontFamily: fontFamily,
    ),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    iconTheme: const IconThemeData(),
    actionsIconTheme: const IconThemeData(color: Colors.black),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.scaffoldBackground,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: Colors.grey,
  ),
  scaffoldBackgroundColor: AppColors.scaffoldBackground,
  primaryColor: AppColors.primaryColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(surface: Colors.white),
);
