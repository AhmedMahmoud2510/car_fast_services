import 'package:quick_cars_service/barrel.dart';

class ClientDrawerWidget extends StatelessWidget {
  const ClientDrawerWidget({super.key});
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
          // DrawerItemWidget(iconAsset: CupertinoIcons.car_detailed,title:'cars'.tr() ,onTap: () async {
          //   context.pushNamed(Routes.clientCarsScreen,arguments: '${await CacheHelper.getData(key: CacheKeys.userId)}');
          //
          // },),
          DrawerItemWidget(
            iconAsset: CupertinoIcons.chat_bubble,
            title: 'chats'.tr(),
            onTap: () async {
              context.pushNamed(Routes.allChatScreen);
            },
          ),
          // DrawerItemWidget(iconAsset: Icons.request_page_outlined,title:'requests'.tr() ,onTap: () async {
          //   context.pushNamed(Routes.homeTechnicianScreen,arguments: '');
          //
          // },),
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
