import 'package:quick_cars_service/barrel.dart';

void showLoading({EasyLoadingMaskType maskType = EasyLoadingMaskType.clear}) {
  EasyLoading.show(maskType: maskType);
}

void hideLoading() {
  EasyLoading.dismiss();
}

void showError(String message) {
  EasyLoading.dismiss();

  EasyLoading.showError(message, dismissOnTap: true);
}

void showSuccess(String message) {
  EasyLoading.dismiss();

  EasyLoading.showSuccess(message, dismissOnTap: true);
}

void showInfo(String message) {
  EasyLoading.dismiss();

  EasyLoading.showInfo(message, dismissOnTap: true);
}

void configLoading(BuildContext context) {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle
        .custom // يستخدم ألواناً مخصصة
    ..backgroundColor = AppColors
        .primaryColor // ضبط لون الخلفية
    ..indicatorColor = AppColors
        .bottomNavLightThemeBackground // يضبط لون مؤشر التحميل الدوار
    ..textColor = AppColors.bottomNavLightThemeBackground
    ..maskColor = AppColors.textColor
    ..dismissOnTap = false
    ..maskType = EasyLoadingMaskType
        .black // يضع طبقة سوداء شفافة على الشاشة خلف المؤشر
    ..userInteractions =
        false // يمنع المستخدم من الضغط على أي شيء على الشاشة أثناء ظهور التحميل
    ..contentPadding = EdgeInsets.all(18.r);
}
