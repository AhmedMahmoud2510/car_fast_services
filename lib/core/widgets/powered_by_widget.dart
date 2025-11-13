import 'package:quick_cars_service/barrel.dart';

class PoweredByWidget extends StatelessWidget {
  const PoweredByWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('powered_by'.tr(), style: Styles.style12W700),
          2.horizontalSpace,
          Image.asset(Assets.alSaifLogo, height: 40.h),
        ],
      ),
    );
  }
}
