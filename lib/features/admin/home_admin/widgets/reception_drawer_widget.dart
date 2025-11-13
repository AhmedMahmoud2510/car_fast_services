import 'package:quick_cars_service/barrel.dart';

class ReceptionDrawerWidget extends StatelessWidget {
  const ReceptionDrawerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryColor,
      width: MediaQuery.of(context).size.width / 2,
      child: ListView(
        children: [
          // Drawer Items
          DrawerItemWidget(
            iconAsset: CupertinoIcons.person,
            title: 'profile'.tr(),
            onTap: () {
              context.pushNamed(Routes.profileScreen);
            },
          ),
          DrawerItemWidget(
            iconAsset: Icons.people_outline,
            title: 'users'.tr(),
            onTap: () {
              context.pushNamed(Routes.usersScreen, arguments: true);
            },
          ),
          BlocProvider(
            create: (context) => AuthCubit(getIt()),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return DrawerItemWidget(
                  iconAsset: Icons.logout,
                  title: 'log_out'.tr(),
                  onTap: () {
                    context.read<AuthCubit>().logout().then((value) {
                      if (value == true) {
                        CacheHelper.sharedPreferences.remove(
                          CacheKeys.userToken,
                        );
                        CacheHelper.sharedPreferences.remove(
                          CacheKeys.userRole,
                        );
                        CacheHelper.sharedPreferences.remove(CacheKeys.userId);
                        context.pushReplacementNamed(Routes.loginScreen);
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
