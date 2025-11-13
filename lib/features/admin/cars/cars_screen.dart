import 'package:quick_cars_service/barrel.dart';

class CarsScreen extends StatelessWidget {
  const CarsScreen({super.key, required this.isReception});
  final bool isReception;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarsCubit, CarsState>(
      listener: (context, state) {
        if (state is AddCarSuccessState ||
            state is UpdateCarSuccessState ||
            state is DeleteCarSuccessState) {
          context.read<CarsCubit>().setOffsetCars(1);
          context.read<CarsCubit>().carsOffsetList.clear();
          context.read<CarsCubit>().getCars();
        }
      },
      builder: (context, state) {
        final ScrollController scrollController = ScrollController();
        bool paginate = false;
        int pageSize = 1;
        int offset = 1;
        if (context.read<CarsCubit>().carsPageSize != null) {
          paginate = context.read<CarsCubit>().carsPaginate;
          pageSize = (context.read<CarsCubit>().carsPageSize! / 5).ceil();
          offset = context.read<CarsCubit>().carsOffset;
        } else {}
        scrollController.addListener(() {
          if ((scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent &&
              context.read<CarsCubit>().carsModel != null &&
              !paginate)) {
            debugPrintWidget(
              'end of page$offset$pageSize${context.read<CarsCubit>().carsPageSize}',
            );
            if (offset < pageSize) {
              context.read<CarsCubit>().setOffsetCars(offset + 1);
              context.read<CarsCubit>().getCars();
            }
          }
        });
        return Scaffold(
          drawer: isReception ? const ReceptionDrawerWidget() : null,
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            onPressed: () {
              context.read<CarsCubit>().getBrands().then((onValue) {
                context.read<CarsCubit>().getMakes().then((onValue) {
                  context.read<CarsCubit>().getUsers().then((onValue) {
                    context.read<CarsCubit>().showUpdateAndAddCarsDialog(
                      context: context,
                      isAdd: true,
                    );
                  });
                });
              });
            },
            child: Text('add'.tr()),
          ),
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
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<CarsCubit>().carSearchController.clear();
              context.read<CarsCubit>().setOffsetCars(1);
              context.read<CarsCubit>().carsOffsetList.clear();
              await context.read<CarsCubit>().getCars();
            },
            child: context.read<CarsCubit>().carsModel != null
                ? context.read<CarsCubit>().carsModel!.data!.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 15.h,
                          ),
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            controller: scrollController,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: context
                                      .read<CarsCubit>()
                                      .carSearchController,
                                  textAlign: TextAlign.center,
                                  onFieldSubmitted: (v) {
                                    context.read<CarsCubit>().carsSearch();
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'search'.tr(),
                                    hintStyle: Styles.style14W500.copyWith(
                                      color: AppColors.primaryColor,
                                    ),
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
                                    ), // Outline border
                                  ),
                                ),
                                30.verticalSpace,
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {
                                      if (!isReception) {
                                        context.pushNamed(
                                          Routes.carVisitsScreen,
                                          arguments: context
                                              .read<CarsCubit>()
                                              .carsModel!
                                              .data![index]
                                              .id,
                                        );
                                      } else {
                                        showAddRequestDialog(
                                          context: context,
                                          isAdmin: false,
                                          carID:
                                              '${context.read<CarsCubit>().carsModel!.data![index].id}',
                                        );
                                      }
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${'manufacturer'.tr()}: ",
                                                  style: Styles.style20W700
                                                      .copyWith(
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                ),
                                                Text(
                                                  '${context.read<CarsCubit>().carsModel!.data![index].make!.name}',
                                                  style: Styles.style18W500
                                                      .copyWith(
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            15.verticalSpace,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${'car_year_release'.tr()}: ",
                                                  style: Styles.style20W700
                                                      .copyWith(
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                ),
                                                Text(
                                                  '${context.read<CarsCubit>().carsModel!.data![index].madeYear}',
                                                  style: Styles.style18W500
                                                      .copyWith(
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            15.verticalSpace,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${'car_number'.tr()}: ",
                                                  style: Styles.style20W700
                                                      .copyWith(
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                ),
                                                Text(
                                                  '${context.read<CarsCubit>().carsModel!.data![index].plateNo}',
                                                  style: Styles.style18W500
                                                      .copyWith(
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                ),
                                              ],
                                            ),

                                            if (!isReception) 15.verticalSpace,
                                            if (!isReception)
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      context
                                                          .read<CarsCubit>()
                                                          .deleteCar(
                                                            id: '${context.read<CarsCubit>().carsModel!.data![index].id}',
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 20.w,
                                                          ),
                                                      child: Text(
                                                        'delete'.tr(),
                                                        style: Styles
                                                            .style18W500
                                                            .copyWith(
                                                              color: AppColors
                                                                  .secondaryColor,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      context.read<CarsCubit>().getBrands().then((
                                                        onValue,
                                                      ) {
                                                        context.read<CarsCubit>().getMakes().then((
                                                          onValue,
                                                        ) {
                                                          context.read<CarsCubit>().getUsers().then((
                                                            onValue,
                                                          ) {
                                                            context
                                                                .read<
                                                                  CarsCubit
                                                                >()
                                                                .showUpdateAndAddCarsDialog(
                                                                  context:
                                                                      context,
                                                                  isAdd: false,
                                                                  index: index,
                                                                  carID:
                                                                      '${context.read<CarsCubit>().carsModel!.data![index].id}',
                                                                  userId: context
                                                                      .read<
                                                                        CarsCubit
                                                                      >()
                                                                      .carsModel!
                                                                      .data![index]
                                                                      .customer!
                                                                      .id,
                                                                );
                                                          });
                                                        });
                                                      });
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 20.w,
                                                          ),
                                                      child: Text(
                                                        'update'.tr(),
                                                        style: Styles
                                                            .style18W500
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
                                  ),
                                  separatorBuilder: (context, index) =>
                                      15.verticalSpace,
                                  itemCount: context
                                      .read<CarsCubit>()
                                      .carsModel!
                                      .data!
                                      .length,
                                ),
                                100.verticalSpace,
                              ],
                            ),
                          ),
                        )
                      : const NoDataWidget()
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
