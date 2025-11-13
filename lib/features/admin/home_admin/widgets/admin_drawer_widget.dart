import 'package:quick_cars_service/barrel.dart';

class AdminDrawerWidget extends StatelessWidget {
  const AdminDrawerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryColor,
      width: MediaQuery.of(context).size.width / 1.2,
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
            iconAsset: Icons.chat_outlined,
            title: 'chats'.tr(),
            onTap: () {
              context.pushNamed(Routes.allChatScreen);
            },
          ),
          DrawerItemWidget(
            iconAsset: Icons.people_outline,
            title: 'users'.tr(),
            onTap: () {
              context.pushNamed(Routes.usersScreen, arguments: false);
            },
          ),
          DrawerItemWidget(
            iconAsset: Icons.branding_watermark_outlined,
            title: 'brands'.tr(),
            onTap: () {
              context.pushNamed(Routes.brandsScreen);
            },
          ),
          DrawerItemWidget(
            iconAsset: CupertinoIcons.car_detailed,
            title: 'cars'.tr(),
            onTap: () {
              context.pushNamed(Routes.carsScreen, arguments: false);
            },
          ),
          DrawerItemWidget(
            iconAsset: Icons.miscellaneous_services,
            title: 'services'.tr(),
            onTap: () {
              context.pushNamed(Routes.homeAdminScreen);
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
