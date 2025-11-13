import 'package:quick_cars_service/barrel.dart';

class CarVisitsScreen extends StatelessWidget {
  const CarVisitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeClientCubit, HomeClientState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<HomeClientCubit>();

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'car_visits_history'.tr(),
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
                    controller: cubit.visitsSearchController,
                    style: Styles.style14W400.copyWith(
                      color: AppColors.primaryColor,
                    ),
                    decoration: InputDecoration(
                      hintText: 'car_visits_search'.tr(),
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
                      cubit.onSearchChangedVisits(value);
                    },
                  ),
                ),

                Expanded(
                  child:
                      (state is GetClientCarsLoadingState &&
                          cubit.carVisitsModel == null)
                      ? const Center(child: CircularProgressIndicator())
                      : cubit.carVisitsModel != null &&
                            cubit.carVisitsModel!.data != null &&
                            cubit.carVisitsModel!.data!.isNotEmpty
                      ? ListView.separated(
                          padding: EdgeInsets.only(bottom: 100.h),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              context.pushNamed(
                                Routes.carMaintenanceScreen,
                                arguments:
                                    cubit.carVisitsModel!.data![index].id,
                              );
                            },
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
                                          "${'visit_date'.tr()}: ",
                                          style: Styles.style20W700.copyWith(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            cubit
                                                .carVisitsModel!
                                                .data![index]
                                                .createdAt!,
                                            style: Styles.style18W500.copyWith(
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${'status'.tr()}: ",
                                          style: Styles.style20W700.copyWith(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            '${cubit.carVisitsModel!.data![index].status}',
                                            style: Styles.style18W500.copyWith(
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (cubit
                                            .carVisitsModel!
                                            .data![index]
                                            .desc !=
                                        null)
                                      15.verticalSpace,
                                    if (cubit
                                            .carVisitsModel!
                                            .data![index]
                                            .desc !=
                                        null)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${'desc'.tr()}: ",
                                            style: Styles.style20W700.copyWith(
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                          Text(
                                            '${cubit.carVisitsModel!.data![index].desc}',
                                            style: Styles.style18W500.copyWith(
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              15.verticalSpace,
                          itemCount: cubit.carVisitsModel!.data!.length,
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
