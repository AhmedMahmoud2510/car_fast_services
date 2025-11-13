import 'package:quick_cars_service/barrel.dart';

part 'home_technician_state.dart';

class HomeTechnicianCubit extends Cubit<HomeTechnicianState> {
  HomeTechnicianCubit(this._homeTechnicianRepo)
    : super(HomeTechnicianInitial());
  final HomeTechnicianRepo _homeTechnicianRepo;
  CarMaintenanceRequestsModel? carMaintenanceRequestsModel;
  List<int> maintenanceRequestsOffsetList = [];
  int maintenanceRequestsOffset = 1;
  bool maintenanceRequestsPaginate = false;
  int? maintenanceRequestsPageSize;
  String? userRole;
  int? clientId;

  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;
  bool isSearching = false;

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 750), () {
      searchCarRequests(query);
    });
  }

  Future<void> searchCarRequests(String query) async {
    if (query.isEmpty) {
      isSearching = false;
      setOffsetMaintenanceRequests(1);
      maintenanceRequestsOffsetList.clear();
      await getCarRequestsMaintenance();
      return;
    }

    isSearching = true;
    showLoading();
    carMaintenanceRequestsModel = null;
    maintenanceRequestsPaginate = true;
    if (!isClosed) emit(GetRequestsLoadingState());

    final result = await _homeTechnicianRepo.searchRequests(query: query);

    hideLoading();
    if (isClosed) return;

    result.fold(
      (l) {
        emit(GetRequestsFailedState());
      },
      (model) {
        carMaintenanceRequestsModel = model;

        maintenanceRequestsPageSize = model.meta!.total;
        if (model.meta!.currentPage == model.meta!.lastPage) {
          maintenanceRequestsPaginate = true;
        } else {
          maintenanceRequestsPaginate = false;
        }

        emit(GetRequestsSuccessState());
      },
    );
  }

  Future<void> getCarRequestsMaintenance({String? carId}) async {
    if (isSearching && maintenanceRequestsOffset > 1) {
      return;
    }
    showLoading();
    userRole = await CacheHelper.getData(key: CacheKeys.userRole);
    clientId = await CacheHelper.getData(key: CacheKeys.userId);
    if (!maintenanceRequestsOffsetList.contains(maintenanceRequestsOffset)) {
      maintenanceRequestsOffsetList.add(maintenanceRequestsOffset);
      emit(GetRequestsLoadingState());
      if (carMaintenanceRequestsModel != null &&
          maintenanceRequestsOffset == 1) {
        carMaintenanceRequestsModel = null;
      }
      final result = userRole == 'technician'
          ? await _homeTechnicianRepo.getCarRequestsMaintenanceTechnician(
              page: '$maintenanceRequestsOffset',
            )
          : userRole == 'client'
          ? await _homeTechnicianRepo.getCarRequestsMaintenanceCar(
              page: '$maintenanceRequestsOffset',
              carId: '$carId',
            )
          : await _homeTechnicianRepo.getCarRequestsMaintenance(
              page: '$maintenanceRequestsOffset',
            );
      result.fold(
        (l) {
          hideLoading();
          emit(GetRequestsFailedState());
        },
        (model) {
          hideLoading();
          if (maintenanceRequestsOffset == 1) {
            carMaintenanceRequestsModel = model;
          } else {
            carMaintenanceRequestsModel!.data!.addAll(model.data!);
          }
          maintenanceRequestsPageSize =
              carMaintenanceRequestsModel!.meta!.total;
          maintenanceRequestsPaginate = false;
          emit(GetRequestsSuccessState());
        },
      );
    } else {
      hideLoading();
      if (maintenanceRequestsPaginate) {
        maintenanceRequestsPaginate = false;
        emit(ChangeMaintenanceRequestsPaginateState());
      }
    }
    if (searchController.text.isEmpty) {
      isSearching = false;
    }
  }

  void setOffsetMaintenanceRequests(int offset) {
    maintenanceRequestsOffset = offset;
    emit(SetOffsetMaintenanceRequestsState());
  }

  RequestDetailsModel? requestDetailsModel;
  Future<void> getRequestDetails({required String requestId}) async {
    showLoading();
    emit(GetRequestDetailsLoadingState());
    final result = await _homeTechnicianRepo.getRequestDetails(
      requestId: requestId,
    );
    result.fold(
      (l) {
        hideLoading();
        emit(GetRequestDetailsFailedState());
      },
      (model) {
        hideLoading();
        requestDetailsModel = model;
        emit(GetRequestDetailsSuccessState());
      },
    );
  }

  TextEditingController descController = TextEditingController();
  List<String> statusList = ['open', 'closed'];
  String selectedStatus = 'open';

  void showUpdateRequestDialog({
    required BuildContext context,
    String? requestId,
    required bool isMaintenance,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Center(
          child: Text(
            'update_request'.tr(),
            style: Styles.style20W600.copyWith(color: AppColors.primaryColor),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'request_status'.tr(),
              style: Styles.style16W600.copyWith(color: AppColors.primaryColor),
            ),
            5.verticalSpace,
            DropdownButtonFormField<String>(
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
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 15.h,
                ),
              ),
              initialValue: selectedStatus,
              items: statusList.map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(
                    status,
                    style: Styles.style14W400.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setRequestStatus(newValue!);
              },
            ),
            // 15.verticalSpace,
            // Text(
            //   'desc'.tr(),
            //   style: Styles.textStyle16W600.copyWith(
            //     color: AppColors.primaryColor,
            //   ),
            // ),
            // 5.verticalSpace,
            // TextFormField(
            //   controller: descController,
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
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  updateRequest(
                    isMaintenance: isMaintenance,
                    id: requestId!,
                  ).then((onValue) {
                    Navigator.pop(context);
                    setOffsetMaintenanceRequests(1);
                    maintenanceRequestsOffsetList.clear();
                    // getCarRequestsMaintenance();
                  });
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
                    'update'.tr(),
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

  void setRequestStatus(String status) {
    selectedStatus = status;
    emit(SetRequestStatusState());
  }

  Future<bool> updateRequest({
    required bool isMaintenance,
    required String id,
  }) async {
    showLoading();
    emit(UpdateRequestLoadingState());

    final result = await _homeTechnicianRepo.updateRequest(
      isMaintenance: isMaintenance,
      requestId: id,
      // desc: descController.text,
      status: selectedStatus,
    );

    return result.fold(
      (failure) {
        hideLoading();
        emit(UpdateRequestFailedState());
        return false;
      },
      (model) {
        hideLoading();
        descController.clear();
        emit(UpdateRequestSuccessState());
        return true;
      },
    );
  }

  Future<bool> deleteRequest({required String id}) async {
    showLoading();
    emit(DeleteRequestLoadingState());

    final result = await _homeTechnicianRepo.deleteRequest(requestId: id);

    return result.fold(
      (failure) {
        hideLoading();
        emit(DeleteRequestFailedState());
        return false;
      },
      (model) {
        hideLoading();
        emit(DeleteRequestSuccessState());
        return true;
      },
    );
  }

  TextEditingController carReadingController = TextEditingController();
  TextEditingController meterTypeCustomController = TextEditingController();
  Future<bool> addRequest({
    required String id,
    required List<int> serviceIds,
  }) async {
    showLoading();
    emit(AddRequestLoadingState());

    final result = await _homeTechnicianRepo.addRequest(
      carId: id,
      serviceIds: serviceIds,
      meterReading: carReadingController.text,
      meterTypeCustom: meterTypeCustomController.text,
    );

    return result.fold(
      (failure) {
        hideLoading();
        emit(AddRequestFailedState());
        return false;
      },
      (model) {
        hideLoading();
        emit(AddRequestSuccessState());
        return true;
      },
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    searchController.dispose();
    return super.close();
  }
}
