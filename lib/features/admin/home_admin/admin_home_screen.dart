import 'package:quick_cars_service/barrel.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeAdminCubit, HomeAdminState>(
      listener: (context, state) {
        if (state is DeleteServicesSuccessState ||
            state is UpdateServicesSuccessState ||
            state is AddServicesSuccessState) {
          context.read<HomeAdminCubit>().setOffsetServices(1);
          context.read<HomeAdminCubit>().servicesOffsetList.clear();
          context.read<HomeAdminCubit>().getServices(isPaginate: true);
        }
      },

      builder: (context, state) {
        final ScrollController scrollController = ScrollController();
        bool paginate = false;
        int pageSize = 1;
        int offset = 1;
        if (context.read<HomeAdminCubit>().servicesPageSize != null) {
          paginate = context.read<HomeAdminCubit>().servicesPaginate;
          pageSize = (context.read<HomeAdminCubit>().servicesPageSize! / 5)
              .ceil();
          offset = context.read<HomeAdminCubit>().servicesOffset;
        } else {}
        scrollController.addListener(() {
          if ((scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent &&
              context.read<HomeAdminCubit>().servicesModel != null &&
              !paginate)) {
            debugPrintWidget(
              'end of page$offset$pageSize${context.read<HomeAdminCubit>().servicesPageSize}',
            );
            if (offset < pageSize) {
              context.read<HomeAdminCubit>().setOffsetServices(offset + 1);
              context.read<HomeAdminCubit>().getServices(isPaginate: true);
            }
          }
        });
        return Scaffold(
          // drawer: AdminDrawerWidget(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            onPressed: () {
              context.read<HomeAdminCubit>().showUpdateAndAddServiceDialog(
                context: context,
                isAdd: true,
              );
            },
            child: Text('add'.tr()),
          ),
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
          body: context.read<HomeAdminCubit>().servicesModel != null
              ? context
                        .read<HomeAdminCubit>()
                        .servicesModel!
                        .products!
                        .isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 15.h,
                        ),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            children: [
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => Container(
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
                                              "${'service_name'.tr()}: ",
                                              style: Styles.style20W700
                                                  .copyWith(
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                '${context.read<HomeAdminCubit>().servicesModel!.products![index].name}',
                                                style: Styles.style18W500
                                                    .copyWith(
                                                      color: AppColors
                                                          .primaryColor,
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
                                              style: Styles.style20W700
                                                  .copyWith(
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                '${context.read<HomeAdminCubit>().servicesModel!.products![index].price}',
                                                style: Styles.style18W500
                                                    .copyWith(
                                                      color: AppColors
                                                          .primaryColor,
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
                                            TextButton(
                                              onPressed: () {
                                                context
                                                    .read<HomeAdminCubit>()
                                                    .deleteService(
                                                      id: '${context.read<HomeAdminCubit>().servicesModel!.products![index].id}',
                                                    );
                                              },
                                              style: TextButton.styleFrom(
                                                backgroundColor: AppColors
                                                    .primaryColor, // Change to your desired color
                                                foregroundColor: AppColors
                                                    .secondaryColor, // Text color
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        15.r,
                                                      ), // Rounded corners
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w,
                                                ),
                                                child: Text(
                                                  'delete'.tr(),
                                                  style: Styles.style18W500
                                                      .copyWith(
                                                        color: AppColors
                                                            .secondaryColor,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                context
                                                    .read<HomeAdminCubit>()
                                                    .showUpdateAndAddServiceDialog(
                                                      context: context,
                                                      isAdd: false,
                                                      index: index,
                                                      serviceName:
                                                          '${context.read<HomeAdminCubit>().servicesModel!.products![index].name}',
                                                      serviceID:
                                                          '${context.read<HomeAdminCubit>().servicesModel!.products![index].id}',
                                                    );
                                              },
                                              style: TextButton.styleFrom(
                                                backgroundColor: AppColors
                                                    .primaryColor, // Change to your desired color
                                                foregroundColor: AppColors
                                                    .secondaryColor, // Text color
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
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
                                                  style: Styles.style18W500
                                                      .copyWith(
                                                        color: AppColors
                                                            .secondaryColor,
                                                      ),
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
                                itemCount: context
                                    .read<HomeAdminCubit>()
                                    .servicesModel!
                                    .products!
                                    .length,
                              ),
                              100.verticalSpace,
                            ],
                          ),
                        ),
                      )
                    : const NoDataWidget()
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
