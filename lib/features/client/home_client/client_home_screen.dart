import 'package:quick_cars_service/barrel.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

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
              'services'.tr(),
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
                    controller: cubit.searchController,
                    style: Styles.style14W400.copyWith(
                      color: AppColors.primaryColor,
                    ),
                    decoration: InputDecoration(
                      hintText: 'services_search'.tr(),
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
                      cubit.onSearchChanged(value);
                    },
                  ),
                ),

                Expanded(
                  child:
                      (state is GetServicesLoadingState &&
                          cubit.servicesModel == null)
                      ? const Center(child: CircularProgressIndicator())
                      : cubit.servicesModel != null &&
                            cubit.servicesModel!.products != null &&
                            cubit.servicesModel!.products!.isNotEmpty
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
                                        "${'service_name'.tr()}: ",
                                        style: Styles.style20W700.copyWith(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          '${cubit.servicesModel!.products![index].name}',
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
                                        "${'price'.tr()}: ",
                                        style: Styles.style20W700.copyWith(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          '${cubit.servicesModel!.products![index].price}',
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
                          itemCount: cubit.servicesModel!.products!.length,
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
