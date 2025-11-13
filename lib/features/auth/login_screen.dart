import 'package:quick_cars_service/barrel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 15.h,
                  ),
                  child: BlocConsumer<AuthCubit, AuthState>(
                    buildWhen: (previous, current) =>
                        current is LoginLoadingState ||
                        current is LoginSuccessState ||
                        current is LoginFailedState,
                    listener: (context, state) async {
                      if (state is LoginSuccessState) {
                        final role = context
                            .read<AuthCubit>()
                            .userModel!
                            .data!
                            .role;
                        if (role == 'admin') {
                          context.pushReplacementNamed(
                            Routes.homeTechnicianScreen,
                            arguments: '',
                          );
                        } else if (role == 'client') {
                          // context.pushReplacementNamed(Routes.homeClientScreen);
                          context.pushNamed(
                            Routes.clientCarsScreen,
                            arguments:
                                '${await CacheHelper.getData(key: CacheKeys.userId)}',
                          );
                        } else if (role == 'technician') {
                          context.pushReplacementNamed(
                            Routes.homeTechnicianScreen,
                            arguments: '',
                          );
                        } else if (role == 'reception') {
                          context.pushReplacementNamed(
                            Routes.carsScreen,
                            arguments: true,
                          );
                        }
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(Assets.logo, height: 100.h),
                          ),
                          10.verticalSpace,
                          Center(
                            child: Text(
                              'welcome'.tr(),
                              style: Styles.style16W600,
                            ),
                          ),
                          20.verticalSpace,
                          Text('phone'.tr(), style: Styles.style14W600),
                          5.verticalSpace,
                          TextFormField(
                            controller: context
                                .read<AuthCubit>()
                                .phoneController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.r),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.r),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.r),
                                ),
                              ),
                            ),
                          ),
                          15.verticalSpace,
                          Text('password'.tr(), style: Styles.style14W600),
                          5.verticalSpace,
                          TextFormField(
                            controller: context
                                .read<AuthCubit>()
                                .passwordController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.r),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.r),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.r),
                                ),
                              ),
                            ),
                          ),
                          30.verticalSpace,
                          SizedBox(
                            height: 50.h,
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                context.read<AuthCubit>().login();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                foregroundColor: AppColors.secondaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                              ),
                              child: Text(
                                'log_in'.tr(),
                                style: Styles.style14W400,
                              ),
                            ),
                          ),
                          // Fills the space and pushes PoweredByWidget to the bottom
                          const Expanded(child: SizedBox()),
                          const PoweredByWidget(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
