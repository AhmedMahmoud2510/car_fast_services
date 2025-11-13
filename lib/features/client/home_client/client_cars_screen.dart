import 'package:quick_cars_service/barrel.dart';

class ClientCarsScreen extends StatelessWidget {
  const ClientCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeClientCubit, HomeClientState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<HomeClientCubit>();

        return Scaffold(
          drawer: const ClientDrawerWidget(),
          appBar: AppBar(
            title: Text(
              'cars'.tr(),
              style: Styles.style16W600.copyWith(
                color: AppColors.secondaryColor,
              ),
            ),
            centerTitle: true,
            backgroundColor: AppColors.primaryColor,
            iconTheme: const IconThemeData(color: AppColors.secondaryColor),
          ),

          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: TextFormField(
                    controller: cubit.carsSearchController,
                    style: Styles.style14W400.copyWith(
                      color: AppColors.primaryColor,
                    ),
                    decoration: InputDecoration(
                      hintText: 'cars_search'.tr(),
                      hintStyle: Styles.style14W400.copyWith(
                        color: AppColors.primaryColor.withAlpha(179),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.primaryColor,
                      ),
                      filled: true,
                      fillColor: AppColors.secondaryColor.withAlpha(26),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 15.h,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.primaryColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15.r)),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.primaryColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15.r)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.primaryColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15.r)),
                      ),
                    ),
                    onChanged: (value) {
                      cubit.onSearchChangedCars(value);
                    },
                  ),
                ),

                Expanded(
                  child:
                      (state is GetClientCarsLoadingState &&
                          cubit.clientCarsModel == null)
                      ? const Center(child: CircularProgressIndicator())
                      : cubit.clientCarsModel != null &&
                            cubit.clientCarsModel!.cars != null &&
                            cubit.clientCarsModel!.cars!.isNotEmpty
                      ? ListView.separated(
                          padding: EdgeInsets.only(bottom: 100.h),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.r),
                                ),
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                  vertical: 15.h,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${'manufacturer'.tr()}: ",
                                          style: Styles.style20W700.copyWith(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        Text(
                                          '${cubit.clientCarsModel!.cars![index].make!.name}',
                                          style: Styles.style18W500.copyWith(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    15.verticalSpace,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${'car_year_release'.tr()}: ",
                                          style: Styles.style20W700.copyWith(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        Text(
                                          '${cubit.clientCarsModel!.cars![index].madeYear}',
                                          style: Styles.style18W500.copyWith(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    15.verticalSpace,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${'car_number'.tr()}: ",
                                          style: Styles.style20W700.copyWith(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        Text(
                                          '${cubit.clientCarsModel!.cars![index].plateNo}',
                                          style: Styles.style18W500.copyWith(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    15.verticalSpace,
                                    TextButton(
                                      onPressed: () {
                                        context.pushNamed(
                                          Routes.homeTechnicianScreen,
                                          arguments:
                                              '${cubit.clientCarsModel!.cars![index].id}',
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                        foregroundColor:
                                            AppColors.secondaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            15.r,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 20.w,
                                        ),
                                        child: Text(
                                          'requests'.tr(),
                                          style: Styles.style18W500.copyWith(
                                            color: AppColors.secondaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              15.verticalSpace,
                          itemCount: cubit.clientCarsModel!.cars!.length,
                        )
                      : const NoDataWidget(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
