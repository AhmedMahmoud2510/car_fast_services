import 'package:quick_cars_service/barrel.dart';

part 'home_admin_state.dart';

class HomeAdminCubit extends Cubit<HomeAdminState> {
  HomeAdminCubit(this._homeAdminRepo) : super(HomeAdminInitial());
  final HomeAdminRepo _homeAdminRepo;
  ProductsModel? servicesModel;
  List<int> servicesOffsetList = [];
  int servicesOffset = 1;
  bool servicesPaginate = false;
  int? servicesPageSize;
  Future<void> getServices({required bool isPaginate}) async {
    showLoading();
    if (!servicesOffsetList.contains(servicesOffset)) {
      servicesOffsetList.add(servicesOffset);
      emit(GetServicesLoadingState());
      if (servicesModel != null && servicesOffset == 1) {
        servicesModel = null;
      }
      final result = await _homeAdminRepo.getServices(
        page: isPaginate ? '$servicesOffset' : null,
      );
      result.fold(
        (l) {
          hideLoading();
          emit(GetServicesFailedState());
        },
        (model) {
          hideLoading();
          if (isPaginate) {
            if (servicesOffset == 1) {
              servicesModel = model;
            } else {
              servicesModel!.products!.addAll(model.products!);
            }
            servicesPageSize = servicesModel!.meta!.total;
            servicesPaginate = false;
          } else {
            servicesModel = model;
          }
          emit(GetServicesSuccessState());
        },
      );
    } else {
      hideLoading();
      if (servicesPaginate) {
        servicesPaginate = false;
        emit(ChangeServicesPaginateState());
      }
    }
  }

  void setOffsetServices(int offset) {
    servicesOffset = offset;
    emit(SetOffsetServicesState());
  }

  Product? addedService;
  Future<void> addService() async {
    showLoading();
    emit(AddServicesLoadingState());
    final result = await _homeAdminRepo.addService(
      title: titleController.text,
      desc: priceController.text,
    );
    result.fold(
      (l) {
        hideLoading();
        emit(AddServicesFailedState());
      },
      (model) {
        hideLoading();
        addedService = model;
        titleController.clear();
        priceController.clear();
        emit(AddServicesSuccessState());
      },
    );
  }

  Future<void> deleteService({required String id}) async {
    showLoading();
    emit(DeleteServicesLoadingState());
    final result = await _homeAdminRepo.deleteService(id: id);
    result.fold(
      (l) {
        hideLoading();
        emit(DeleteServicesFailedState());
      },
      (model) {
        hideLoading();
        servicesModel = model;
        emit(DeleteServicesSuccessState());
      },
    );
  }

  void showUpdateAndAddServiceDialog({
    required BuildContext context,
    required bool isAdd,
    int? index,
    String? serviceName,
    String? serviceID,
  }) {
    if (!isAdd) {
      titleController.text = serviceName!;
      priceController.text = servicesModel!.products![index!].price ?? '';
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Center(
          child: Text(
            isAdd ? 'add_service'.tr() : serviceName!,
            style: Styles.style20W600.copyWith(color: AppColors.primaryColor),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'service_name'.tr(),
              style: Styles.style16W600.copyWith(color: AppColors.primaryColor),
            ),
            5.verticalSpace,
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                ), // Outline border
              ),
            ),
            15.verticalSpace,
            Text(
              'desc'.tr(),
              style: Styles.style16W600.copyWith(color: AppColors.primaryColor),
            ),
            5.verticalSpace,
            TextFormField(
              controller: priceController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                ), // Outline border
              ),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  if (isAdd) {
                    addService().then((v) {
                      Navigator.pop(context);
                    });
                  } else {
                    updateService(id: serviceID!).then((v) {
                      Navigator.pop(context);
                    });
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      AppColors.primaryColor, // Change to your desired color
                  foregroundColor: AppColors.secondaryColor, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      15.r,
                    ), // Rounded corners
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    isAdd ? 'add'.tr() : 'update'.tr(),
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
                  foregroundColor: AppColors.primaryColor, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      15.r,
                    ), // Rounded corners
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
      ),
    );
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  Product? updatedService;
  Future<void> updateService({required String id}) async {
    showLoading();
    emit(UpdateServicesLoadingState());
    final result = await _homeAdminRepo.updateService(
      id: id,
      title: titleController.text,
      price: priceController.text,
    );
    result.fold(
      (l) {
        hideLoading();
        emit(UpdateServicesFailedState());
      },
      (model) {
        hideLoading();
        updatedService = model;
        titleController.clear();
        priceController.clear();
        emit(UpdateServicesSuccessState());
      },
    );
  }
}
