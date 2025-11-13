import 'package:quick_cars_service/barrel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'profile'.tr(),
          style: Styles.style16W600.copyWith(color: AppColors.secondaryColor),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: AppColors.secondaryColor),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        buildWhen: (previous, current) =>
            current is GetProfileLoadingState ||
            current is GetProfileSuccessState ||
            current is GetProfileFailedState,
        builder: (context, state) {
          return context.read<AuthCubit>().profileModel != null
              ? context.read<AuthCubit>().profileModel!.data != null
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 15.h,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${'name'.tr()}: ",
                                  style: Styles.style20W700.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  '${context.read<AuthCubit>().profileModel!.data!.name}',
                                  style: Styles.style18W500.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            15.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${'phone'.tr()}: ",
                                  style: Styles.style20W700.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  '${context.read<AuthCubit>().profileModel!.data!.phone}',
                                  style: Styles.style18W500.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            15.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${'acc_type'.tr()}: ",
                                  style: Styles.style20W700.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  '${context.read<AuthCubit>().profileModel!.data!.role}',
                                  style: Styles.style18W500.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),

                            15.verticalSpace,
                            BlocProvider(
                              create: (context) => UsersCubit(getIt()),
                              child: BlocConsumer<UsersCubit, UsersState>(
                                listener: (context, state) {
                                  if (state is UpdateUserSuccessState) {
                                    context.read<AuthCubit>().getProfile();
                                  }
                                },
                                builder: (context, state) {
                                  return TextButton(
                                    onPressed: () async {
                                      final userRole =
                                          await CacheHelper.getData(
                                            key: CacheKeys.userRole,
                                          );

                                      context.read<UsersCubit>().showUpdateAndAddUsersDialog(
                                        context: context,
                                        isAdd: false,
                                        isReception: false,
                                        isAdmin: userRole == 'admin'
                                            ? true
                                            : false,
                                        userName:
                                            '${context.read<AuthCubit>().profileModel!.data!.name}',
                                        phone:
                                            '${context.read<AuthCubit>().profileModel!.data!.phone}',
                                        role:
                                            '${context.read<AuthCubit>().profileModel!.data!.role}',
                                        userID:
                                            '${context.read<AuthCubit>().profileModel!.data!.id}',
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      // Change to your desired color
                                      foregroundColor: AppColors.secondaryColor,
                                      // Text color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          15.r,
                                        ), // Rounded corners
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                      ),
                                      child: Text(
                                        'update'.tr(),
                                        style: Styles.style18W500.copyWith(
                                          color: AppColors.secondaryColor,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : const NoDataWidget()
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
