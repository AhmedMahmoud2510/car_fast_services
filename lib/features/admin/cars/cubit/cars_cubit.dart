import 'package:quick_cars_service/barrel.dart';

part 'cars_state.dart';

class CarsCubit extends Cubit<CarsState> {
  CarsCubit(this._carsRepo) : super(CarsInitial());
  final CarsRepo _carsRepo;

  BrandsModel? brandsModel;

  Future<void> getBrands() async {
    emit(GetBrandsLoadingState());
    final result = await _carsRepo.getBrands();
    result.fold((l) => emit(GetBrandsFailedState()), (model) {
      brandsModel = model;
      selectedBrand = brandsModel!.data!.first;
      emit(GetBrandsSuccessState());
    });
  }

  BrandsModel? makesModel;

  Future<void> getMakes() async {
    emit(GetMakesLoadingState());
    final result = await _carsRepo.getMakes();
    result.fold((l) => emit(GetMakesFailedState()), (model) {
      makesModel = model;
      selectedMake = makesModel!.data!.first;
      emit(GetMakesSuccessState());
    });
  }

  UsersModel? usersModel;
  Future<void> getUsers() async {
    emit(GetBrandsLoadingState());
    final result = await _carsRepo.getUsers();
    result.fold((l) => emit(GetBrandsFailedState()), (model) {
      usersModel = model;
      selectedUser = usersModel!.data!.first;
      emit(GetBrandsSuccessState());
    });
  }

  CarsModel? carsModel;
  List<int> carsOffsetList = [];
  int carsOffset = 1;
  bool carsPaginate = false;
  int? carsPageSize;
  Future<void> getCars() async {
    showLoading();
    if (!carsOffsetList.contains(carsOffset)) {
      carsOffsetList.add(carsOffset);
      emit(GetCarsLoadingState());
      if (carsModel != null && carsOffset == 1) {
        carsModel = null;
      }
      final result = await _carsRepo.getCars(page: '$carsOffset');
      result.fold(
        (l) {
          hideLoading();
          emit(GetCarsFailedState());
        },
        (model) {
          hideLoading();
          if (carsOffset == 1) {
            carsModel = model;
          } else {
            carsModel!.data!.addAll(model.data!);
          }
          carsPageSize = carsModel!.meta!.total;
          carsPaginate = false;
          emit(GetCarsSuccessState());
        },
      );
    } else {
      hideLoading();
      if (carsPaginate) {
        carsPaginate = false;
        emit(ChangeCarsPaginateState());
      }
    }
  }

  void setOffsetCars(int offset) {
    carsOffset = offset;
    emit(SetOffsetCarsState());
  }

  Car? addedCar;
  Future<void> addCar() async {
    showLoading();
    emit(AddCarLoadingState());
    final result = await _carsRepo.addCar(
      brandID: '${selectedBrand!.id}',
      makeID: '${selectedMake!.id}',
      carNumber: carNumberController.text,
      year: yearController.text,
      bodyNumber: bodyNumberController.text,
      // carMeter: carMeterController.text,
      userId: selectedUser != null ? '${selectedUser!.id}' : selectedUserId!,
    );
    result.fold(
      (l) {
        hideLoading();
        emit(AddCarFailedState());
      },
      (model) {
        hideLoading();
        addedCar = model;
        carNumberController.clear();
        yearController.clear();
        carMeterController.clear();
        bodyNumberController.clear();
        selectedBrand = null;
        selectedUser = null;
        selectedUserId = null;
        emit(AddCarSuccessState());
      },
    );
  }

  Future<bool> deleteCar({required String id}) async {
    showLoading();
    emit(DeleteCarLoadingState());

    final result = await _carsRepo.deleteCar(carId: id);

    return result.fold(
      (failure) {
        hideLoading();
        emit(DeleteCarFailedState());
        return false;
      },
      (model) {
        hideLoading();
        emit(DeleteCarSuccessState());
        return true;
      },
    );
  }

  Car? updatedCar;
  Future<void> updateCar({required String id}) async {
    showLoading();
    emit(UpdateCarLoadingState());
    final result = await _carsRepo.updateCar(
      carId: id,
      brandID: '${selectedBrand!.id}',
      makeID: '${selectedMake!.id}',
      carNumber: carNumberController.text,
      year: yearController.text,
      bodyNumber: bodyNumberController.text,
      carMeter: carMeterController.text,
      userId: selectedUser != null ? '${selectedUser!.id}' : selectedUserId!,
    );
    result.fold(
      (l) {
        hideLoading();
        emit(UpdateCarFailedState());
      },
      (model) {
        hideLoading();
        updatedCar = model;
        carNumberController.clear();
        yearController.clear();
        carMeterController.clear();
        bodyNumberController.clear();
        selectedBrand = null;
        selectedMake = null;
        selectedUser = null;
        selectedUserId = null;
        emit(UpdateCarSuccessState());
      },
    );
  }

  TextEditingController carNumberController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController bodyNumberController = TextEditingController();
  TextEditingController carMeterController = TextEditingController();
  Brand? selectedBrand;
  Brand? selectedMake;
  User? selectedUser;
  String? selectedUserId;
  void showUpdateAndAddCarsDialog({
    required BuildContext context,
    required bool isAdd,
    int? index,
    String? carID,
    int? userId,
  }) {
    if (!isAdd) {
      carNumberController.text = carsModel!.data![index!].plateNo!;
      yearController.text = carsModel!.data![index].madeYear!;
      bodyNumberController.text = carsModel!.data![index].chassisNo!;
      selectedUser =
          usersModel!.data![usersModel!.data!.indexWhere(
            (element) => element.id == userId,
          )];
    }
    if (isAdd && usersModel == null) {
      selectedUserId = '$userId';
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Center(
          child: Text(
            isAdd ? 'add_car'.tr() : 'update_car'.tr(),
            style: Styles.style20W600.copyWith(color: AppColors.primaryColor),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (userId == null)
                Text(
                  'client_name'.tr(),
                  style: Styles.style16W600.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              if (userId == null) 5.verticalSpace,
              if (userId == null)
                usersModel!.data != null
                    ? DropdownButtonFormField<User>(
                        isExpanded: true, // ✅ مهم جداً يمنع overflow
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
                        initialValue: selectedUser,
                        items: usersModel!.data!.map((user) {
                          return DropdownMenuItem<User>(
                            value: user,
                            child: Text(
                              user.name ?? '',
                              style: Styles.style14W400.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newUser) {
                          selectedUser = newUser;
                        },
                      )
                    : const SizedBox.shrink(),
              5.verticalSpace,
              Text(
                'car_brand'.tr(),
                style: Styles.style16W600.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              5.verticalSpace,
              if (brandsModel!.data != null)
                DropdownButtonFormField<Brand>(
                  isExpanded: true, // ✅ مهم جداً يمنع overflow
                  decoration: InputDecoration(
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
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 15.h,
                    ),
                  ),
                  initialValue: selectedBrand,
                  items: brandsModel!.data!.map((brand) {
                    return DropdownMenuItem<Brand>(
                      value: brand,
                      child: Text(
                        brand.name ?? '',
                        style: Styles.style14W400.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newBrand) {
                    selectedBrand = newBrand;
                  },
                ),
              5.verticalSpace,
              Text(
                'car_make'.tr(),
                style: Styles.style16W600.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              5.verticalSpace,
              if (makesModel!.data != null)
                DropdownButtonFormField<Brand>(
                  isExpanded: true, // ✅ مهم جداً يمنع overflow
                  decoration: InputDecoration(
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
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 15.h,
                    ),
                  ),
                  initialValue: selectedMake,
                  items: makesModel!.data!.map((make) {
                    return DropdownMenuItem<Brand>(
                      value: make,
                      child: Text(
                        make.name ?? '',
                        style: Styles.style14W400.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newMake) {
                    selectedMake = newMake;
                  },
                ),
              5.verticalSpace,
              Text(
                'car_number'.tr(),
                style: Styles.style16W600.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              5.verticalSpace,
              TextFormField(
                controller: carNumberController,
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
                'car_year_release'.tr(),
                style: Styles.style16W600.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              5.verticalSpace,
              TextFormField(
                controller: yearController,
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
                'car_body_number'.tr(),
                style: Styles.style16W600.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              5.verticalSpace,
              TextFormField(
                controller: bodyNumberController,
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
              // Text(
              //   'car_meter'.tr(),
              //   style: Styles.textStyle16W600.copyWith(
              //     color: AppColors.primaryColor,
              //   ),
              // ),
              // 5.verticalSpace,
              // TextFormField(
              //   controller: carMeterController,
              //   decoration: InputDecoration(
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: AppColors.primaryColor),
              //       borderRadius: BorderRadius.all(Radius.circular(15.r)),
              //     ),
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide(color: AppColors.primaryColor),
              //       borderRadius: BorderRadius.all(Radius.circular(15.r)),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(color: AppColors.primaryColor),
              //       borderRadius: BorderRadius.all(Radius.circular(15.r)),
              //     ), // Outline border
              //   ),
              // ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  if (isAdd) {
                    addCar().then((v) {
                      Navigator.pop(context);
                    });
                  } else {
                    updateCar(id: carID!).then((v) {
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

  TextEditingController carSearchController = TextEditingController();
  Future<void> carsSearch() async {
    showLoading();
    emit(CarsSearchLoadingState());
    final result = await _carsRepo.carsSearch(
      carNumber: carSearchController.text,
    );
    result.fold(
      (l) {
        hideLoading();
        emit(CarsSearchFailedState());
      },
      (model) {
        hideLoading();
        carsModel = model;
        emit(CarsSearchSuccessState());
      },
    );
  }
}
