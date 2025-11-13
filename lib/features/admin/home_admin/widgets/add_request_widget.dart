import 'package:quick_cars_service/barrel.dart';

Future<void> showAddRequestDialog({
  required BuildContext context,
  required bool isAdmin,
  int? index,
  String? carID,
  int? brandId,
  int? userId,
}) async {
  Car? selectedCar;
  List<Product> selectedServices = [];

  await showDialog(
    context: context,
    builder: (dialogContext) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                HomeAdminCubit(getIt())..getServices(isPaginate: false),
          ),
          BlocProvider(create: (_) => CarsCubit(getIt())..getCars()),
          BlocProvider(create: (_) => HomeTechnicianCubit(getIt())),
        ],
        child: Builder(
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              title: Center(
                child: Text(
                  'add_request'.tr(),
                  style: Styles.style20W600.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              content: SingleChildScrollView(
                child: BlocBuilder<CarsCubit, CarsState>(
                  builder: (context, state) {
                    return BlocBuilder<HomeAdminCubit, HomeAdminState>(
                      builder: (context, state) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isAdmin)
                              Text(
                                'car_number'.tr(),
                                style: Styles.style16W600.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            if (isAdmin) 5.verticalSpace,
                            if (isAdmin)
                              if (context.read<CarsCubit>().carsModel != null)
                                DropdownButtonFormField<Car>(
                                  isExpanded: true,
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
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15.w,
                                      vertical: 15.h,
                                    ),
                                  ),
                                  initialValue: selectedCar,
                                  items: context
                                      .read<CarsCubit>()
                                      .carsModel!
                                      .data!
                                      .map(
                                        (car) => DropdownMenuItem<Car>(
                                          value: car,
                                          child: Text(
                                            car.plateNo ?? '',
                                            style: Styles.style14W400.copyWith(
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (newCar) {
                                    selectedCar = newCar;
                                  },
                                ),
                            15.verticalSpace,
                            Text(
                              'meter_reading'.tr(),
                              style: Styles.style16W600.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            5.verticalSpace,
                            TextFormField(
                              controller: context
                                  .read<HomeTechnicianCubit>()
                                  .carReadingController,
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
                                ), // Outline border
                              ),
                            ),

                            15.verticalSpace,
                            Text(
                              'meter_type_custom'.tr(),
                              style: Styles.style16W600.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            5.verticalSpace,
                            TextFormField(
                              controller: context
                                  .read<HomeTechnicianCubit>()
                                  .meterTypeCustomController,
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
                                ), // Outline border
                              ),
                            ),
                            15.verticalSpace,
                            Text(
                              'services'.tr(),
                              style: Styles.style16W600.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            5.verticalSpace,
                            if (context.read<HomeAdminCubit>().servicesModel !=
                                null)
                              MultiSelectDialogField<Product>(
                                items: context
                                    .read<HomeAdminCubit>()
                                    .servicesModel!
                                    .products!
                                    .map(
                                      (service) => MultiSelectItem<Product>(
                                        service,
                                        service.name ?? '',
                                      ),
                                    )
                                    .toList(),
                                title: Text(
                                  'services'.tr(),
                                  style: Styles.style16W600.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                selectedColor: AppColors.primaryColor,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                buttonIcon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.primaryColor,
                                ),
                                buttonText: Text(
                                  selectedServices.isEmpty
                                      ? 'select_services'.tr()
                                      : '${selectedServices.length} ${"selected".tr()}',
                                  style: Styles.style14W400.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                onConfirm: (values) {
                                  selectedServices = values;
                                },
                              ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        final serviceIds = selectedServices
                            .map((s) => s.id!)
                            .toList();
                        context
                            .read<HomeTechnicianCubit>()
                            .addRequest(id: carID!, serviceIds: serviceIds)
                            .then((onValue) {
                              Navigator.pop(context);
                            });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          'add'.tr(),
                          style: Styles.style18W500.copyWith(
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          'cancel'.tr(),
                          style: Styles.style18W500.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
