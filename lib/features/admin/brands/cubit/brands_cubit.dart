import 'package:quick_cars_service/barrel.dart';

part 'brands_state.dart';

class BrandsCubit extends Cubit<BrandsState> {
  BrandsCubit(this._brandsRepo) : super(BrandsInitial());
  final BrandsRepo _brandsRepo;
  BrandsModel? brandsModel;
  List<int> brandsOffsetList = [];
  int brandsOffset = 1;
  bool brandsPaginate = false;
  int? brandsPageSize;
  Future<void> getBrands() async {
    showLoading();
    if (!brandsOffsetList.contains(brandsOffset)) {
      brandsOffsetList.add(brandsOffset);
      emit(GetBrandsLoadingState());
      if (brandsModel != null && brandsOffset == 1) {
        brandsModel = null;
      }
      final result = await _brandsRepo.getBrands(page: '$brandsOffset');
      result.fold(
        (l) {
          hideLoading();
          emit(GetBrandsFailedState());
        },
        (model) {
          hideLoading();
          if (brandsOffset == 1) {
            brandsModel = model;
          } else {
            brandsModel!.data!.addAll(model.data!);
          }
          brandsPageSize = brandsModel!.meta!.total;
          brandsPaginate = false;
          emit(GetBrandsSuccessState());
        },
      );
    } else {
      hideLoading();
      if (brandsPaginate) {
        brandsPaginate = false;
        emit(ChangeBrandsPaginateState());
      }
    }
  }

  void setOffsetBrands(int offset) {
    brandsOffset = offset;
    emit(SetOffsetBrandsState());
  }

  Brand? addedBrand;
  Future<void> addBrand() async {
    showLoading();
    emit(AddBrandLoadingState());
    final result = await _brandsRepo.addBrand(name: nameController.text);
    result.fold(
      (l) {
        hideLoading();
        emit(AddBrandFailedState());
      },
      (model) {
        hideLoading();
        addedBrand = model;
        nameController.clear();
        emit(AddBrandSuccessState());
      },
    );
  }

  Future<bool> deleteBrand({required String id}) async {
    showLoading();
    emit(DeleteBrandLoadingState());

    final result = await _brandsRepo.deleteBrand(brandId: id);

    return result.fold(
      (failure) {
        hideLoading();
        emit(DeleteBrandFailedState());
        return false;
      },
      (model) {
        hideLoading();
        emit(DeleteBrandSuccessState());
        return true;
      },
    );
  }

  Brand? updatedBrand;
  Future<void> updateBrand({required String id}) async {
    showLoading();
    emit(UpdateBrandLoadingState());
    final result = await _brandsRepo.updateBrand(
      brandId: id,
      name: nameController.text,
    );
    result.fold(
      (l) {
        hideLoading();
        emit(UpdateBrandFailedState());
      },
      (model) {
        hideLoading();
        updatedBrand = model;
        nameController.clear();
        emit(UpdateBrandSuccessState());
      },
    );
  }

  TextEditingController nameController = TextEditingController();

  void showUpdateAndAddBrandsDialog({
    required BuildContext context,
    required bool isAdd,
    int? index,
    String? brandId,
  }) {
    if (!isAdd) {
      nameController.text = brandsModel!.data![index!].name!;
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Center(
          child: Text(
            isAdd ? 'add_brand'.tr() : 'update_brand'.tr(),
            style: Styles.style20W600.copyWith(color: AppColors.primaryColor),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'car_brand'.tr(),
              style: Styles.style16W600.copyWith(color: AppColors.primaryColor),
            ),
            5.verticalSpace,
            TextFormField(
              controller: nameController,
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
                    addBrand().then((v) {
                      Navigator.pop(context);
                    });
                  } else {
                    updateBrand(id: brandId!).then((v) {
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

  BrandsModel? makesModel;
  List<int> makesOffsetList = [];
  int makesOffset = 1;
  bool makesPaginate = false;
  int? makesPageSize;
  Future<void> getMakes() async {
    showLoading();
    if (!makesOffsetList.contains(makesOffset)) {
      makesOffsetList.add(makesOffset);
      emit(GetMakesLoadingState());
      if (makesModel != null && makesOffset == 1) {
        makesModel = null;
      }
      final result = await _brandsRepo.getMake(page: '$makesOffset');
      result.fold(
        (l) {
          hideLoading();
          emit(GetMakesFailedState());
        },
        (model) {
          hideLoading();
          if (makesOffset == 1) {
            makesModel = model;
          } else {
            makesModel!.data!.addAll(model.data!);
          }
          makesPageSize = makesModel!.meta!.total;
          makesPaginate = false;
          emit(GetMakesSuccessState());
        },
      );
    } else {
      hideLoading();
      if (makesPaginate) {
        makesPaginate = false;
        emit(ChangeMakesPaginateState());
      }
    }
  }

  void setOffsetMakes(int offset) {
    makesOffset = offset;
    emit(SetOffsetMakesState());
  }
}
