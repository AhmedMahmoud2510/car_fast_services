import 'package:quick_cars_service/barrel.dart';

class CarMaintenanceScreen extends StatelessWidget {
  const CarMaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeClientCubit, HomeClientState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<HomeClientCubit>();

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'car_maintenance_history'.tr(),
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
                    controller: cubit.maintenanceSearchController,
                    style: Styles.style14W400.copyWith(
                      color: AppColors.primaryColor,
                    ),
                    decoration: InputDecoration(
                      hintText: 'car_maintenance_search'.tr(),
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
                      cubit.onSearchChangedMaintenance(value);
                    },
                  ),
                ),

                Expanded(
                  child:
                      (state is GetClientCarsLoadingState &&
                          cubit.carMaintenanceModel == null)
                      ? const Center(child: CircularProgressIndicator())
                      : cubit.carMaintenanceModel != null &&
                            cubit.carMaintenanceModel!.carServices != null &&
                            cubit.carMaintenanceModel!.carServices!.isNotEmpty
                      ? ListView.separated(
                          padding: EdgeInsets.only(bottom: 100.h),
                          itemBuilder: (context, index) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.r),
                              ),
                              border: Border.all(color: AppColors.primaryColor),
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
                                        "${'service_date'.tr()}: ",
                                        style: Styles.style20W700.copyWith(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          DateFormat('yyyy/M/d, h:mm a').format(
                                            DateFormat(
                                              'MMMM d, yyyy - h:mm a',
                                              'en_US',
                                            ).parse(
                                              cubit
                                                  .carMaintenanceModel!
                                                  .carServices![index]
                                                  .createdAt!,
                                            ),
                                          ),
                                          style: Styles.style18W500.copyWith(
                                            color: AppColors.primaryColor,
                                          ),
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
                                        "${'service_name'.tr()}: ",
                                        style: Styles.style20W700.copyWith(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      Text(
                                        '${cubit.carMaintenanceModel!.carServices![index].serviceName}',
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
                                        "${'service_desc'.tr()}: ",
                                        style: Styles.style20W700.copyWith(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          '${cubit.carMaintenanceModel!.carServices![index].serviceDesc}',
                                          style: Styles.style18W500.copyWith(
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              15.verticalSpace,
                          itemCount:
                              cubit.carMaintenanceModel!.carServices!.length,
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
