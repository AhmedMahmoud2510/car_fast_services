import 'package:quick_cars_service/barrel.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'no_data_found'.tr(),
            style: Styles.style16W600.copyWith(color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
