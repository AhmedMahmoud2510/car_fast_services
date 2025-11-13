import 'package:quick_cars_service/barrel.dart';

class Separator extends StatelessWidget {
  const Separator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 1.h,
      color: AppColors.primaryColor,
    );
  }
}
