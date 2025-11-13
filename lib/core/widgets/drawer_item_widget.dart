import 'package:quick_cars_service/barrel.dart';

class DrawerItemWidget extends StatelessWidget {
  final IconData iconAsset;
  final String title;
  final GestureTapCallback onTap;
  const DrawerItemWidget({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconAsset, color: AppColors.secondaryColor),
      title: Text(
        title,
        style: Styles.style14W400.copyWith(
          color: AppColors.secondaryColor,
          fontSize: 14.sp,
        ),
      ),
      onTap: onTap,
    );
  }
}
