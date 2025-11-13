import 'package:quick_cars_service/barrel.dart';

part 'home_client_state.dart';

class HomeClientCubit extends Cubit<HomeClientState> {
  HomeClientCubit(this._homeClientRepo) : super(HomeClientInitial());
  final HomeClientRepo _homeClientRepo;

  // --- 1. بحث الخدمات (من المرة السابقة) ---
  ProductsModel? servicesModel;
  ProductsModel? _allServicesModel;
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _filterServices(query);
    });
  }

  void _filterServices(String query) {
    if (_allServicesModel == null || _allServicesModel!.products == null) {
      return;
    }
    if (query.isEmpty) {
      servicesModel = ProductsModel.fromJson(_allServicesModel!.toJson());
      emit(GetServicesSuccessState());
      return;
    }
    final filteredProducts = _allServicesModel!.products!
        .where(
          (product) =>
              product.name != null &&
              product.name!.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    var newFilteredModel = ProductsModel.fromJson(_allServicesModel!.toJson());
    newFilteredModel.products = filteredProducts;
    servicesModel = newFilteredModel;
    emit(GetServicesSuccessState());
  }

  Future<void> getServices() async {
    showLoading();
    emit(GetServicesLoadingState());
    final result = await _homeClientRepo.getServices();
    result.fold(
      (l) {
        hideLoading();
        emit(GetServicesFailedState());
      },
      (model) {
        hideLoading();
        _allServicesModel = ProductsModel.fromJson(model.toJson()); // الأصلية
        servicesModel = model; // المعروضة
        emit(GetServicesSuccessState());
      },
    );
  }

  // --- 2. بحث سيارات العميل (Client Cars) ---
  ClientCarsModel? clientCarsModel;
  ClientCarsModel? _allClientCarsModel; // +++ قائمة أصلية
  final TextEditingController carsSearchController = // +++ Controller جديد
      TextEditingController();
  Timer? _debounceCars; // +++ Debouncer جديد

  void onSearchChangedCars(String query) {
    // +++ دالة جديدة
    if (_debounceCars?.isActive ?? false) _debounceCars!.cancel();
    _debounceCars = Timer(const Duration(milliseconds: 500), () {
      _filterClientCars(query);
    });
  }

  void _filterClientCars(String query) {
    // +++ دالة جديدة
    if (_allClientCarsModel == null || _allClientCarsModel!.cars == null) {
      return;
    }

    if (query.isEmpty) {
      clientCarsModel = ClientCarsModel.fromJson(_allClientCarsModel!.toJson());
      emit(GetClientCarsSuccessState());
      return;
    }

    final filteredCars = _allClientCarsModel!.cars!.where((car) {
      final plateNo = car.plateNo?.toLowerCase() ?? '';
      final makeName = car.make?.name?.toLowerCase() ?? '';
      final queryLower = query.toLowerCase();
      // البحث برقم اللوحة أو اسم المصنع
      return plateNo.contains(queryLower) || makeName.contains(queryLower);
    }).toList();

    var newModel = ClientCarsModel.fromJson(_allClientCarsModel!.toJson());
    newModel.cars = filteredCars;
    clientCarsModel = newModel;
    emit(GetClientCarsSuccessState());
  }

  Future<void> getClientCars({required String userId}) async {
    showLoading();
    emit(GetClientCarsLoadingState());
    final result = await _homeClientRepo.getClientCars(id: userId);
    result.fold(
      (l) {
        hideLoading();
        emit(GetClientCarsFailedState());
      },
      (model) {
        hideLoading();
        _allClientCarsModel = ClientCarsModel.fromJson(
          model.toJson(),
        ); // +++ الأصلية
        clientCarsModel = model; // +++ المعروضة
        emit(GetClientCarsSuccessState());
      },
    );
  }

  // --- 3. بحث زيارات السيارة (Car Visits) ---
  CarVisitsModel? carVisitsModel;
  CarVisitsModel? _allCarVisitsModel; // +++ قائمة أصلية
  final TextEditingController visitsSearchController = // +++ Controller جديد
      TextEditingController();
  Timer? _debounceVisits; // +++ Debouncer جديد

  void onSearchChangedVisits(String query) {
    // +++ دالة جديدة
    if (_debounceVisits?.isActive ?? false) _debounceVisits!.cancel();
    _debounceVisits = Timer(const Duration(milliseconds: 500), () {
      _filterCarVisits(query);
    });
  }

  void _filterCarVisits(String query) {
    // +++ دالة جديدة
    if (_allCarVisitsModel == null || _allCarVisitsModel!.data == null) return;

    if (query.isEmpty) {
      carVisitsModel = CarVisitsModel.fromJson(_allCarVisitsModel!.toJson());
      emit(GetClientCarsSuccessState()); // (نفس الـ state لا مشكلة)
      return;
    }

    final filteredVisits = _allCarVisitsModel!.data!.where((visit) {
      final date = visit.createdAt?.toLowerCase() ?? '';
      final status = visit.status?.toLowerCase() ?? '';
      final queryLower = query.toLowerCase();
      // البحث بالتاريخ أو الحالة
      return date.contains(queryLower) || status.contains(queryLower);
    }).toList();

    var newModel = CarVisitsModel.fromJson(_allCarVisitsModel!.toJson());
    newModel.data = filteredVisits;
    carVisitsModel = newModel;
    emit(GetClientCarsSuccessState());
  }

  Future<void> getCarVisits({required String carID}) async {
    showLoading();
    emit(GetClientCarsLoadingState());
    final result = await _homeClientRepo.getCarVisits(id: carID);
    result.fold(
      (l) {
        hideLoading();
        emit(GetClientCarsFailedState());
      },
      (model) {
        hideLoading();
        _allCarVisitsModel = CarVisitsModel.fromJson(
          model.toJson(),
        ); // +++ الأصلية
        carVisitsModel = model; // +++ المعروضة
        emit(GetClientCarsSuccessState());
      },
    );
  }

  // --- 4. بحث صيانة السيارة (Car Maintenance) ---
  CarMaintenanceModel? carMaintenanceModel;
  CarMaintenanceModel? _allCarMaintenanceModel; // +++ قائمة أصلية
  final TextEditingController
  maintenanceSearchController = // +++ Controller جديد
      TextEditingController();
  Timer? _debounceMaintenance; // +++ Debouncer جديد

  void onSearchChangedMaintenance(String query) {
    // +++ دالة جديدة
    if (_debounceMaintenance?.isActive ?? false) _debounceMaintenance!.cancel();
    _debounceMaintenance = Timer(const Duration(milliseconds: 500), () {
      _filterCarMaintenance(query);
    });
  }

  void _filterCarMaintenance(String query) {
    // +++ دالة جديدة
    if (_allCarMaintenanceModel == null ||
        _allCarMaintenanceModel!.carServices == null) {
      return;
    }

    if (query.isEmpty) {
      carMaintenanceModel = CarMaintenanceModel.fromJson(
        _allCarMaintenanceModel!.toJson(),
      );
      emit(GetClientCarsSuccessState());
      return;
    }

    final filteredServices = _allCarMaintenanceModel!.carServices!.where((
      service,
    ) {
      final name = service.serviceName?.toLowerCase() ?? '';
      final desc = service.serviceDesc?.toLowerCase() ?? '';
      final queryLower = query.toLowerCase();
      // البحث باسم الخدمة أو الوصف
      return name.contains(queryLower) || desc.contains(queryLower);
    }).toList();

    var newModel = CarMaintenanceModel.fromJson(
      _allCarMaintenanceModel!.toJson(),
    );
    newModel.carServices = filteredServices;
    carMaintenanceModel = newModel;
    emit(GetClientCarsSuccessState());
  }

  Future<void> getCarMaintenance({required String visitId}) async {
    showLoading();
    emit(GetClientCarsLoadingState());
    final result = await _homeClientRepo.getCarMaintenance(id: visitId);
    result.fold(
      (l) {
        hideLoading();
        emit(GetClientCarsFailedState());
      },
      (model) {
        hideLoading();
        _allCarMaintenanceModel = CarMaintenanceModel.fromJson(
          model.toJson(),
        ); // +++ الأصلية
        carMaintenanceModel = model; // +++ المعروضة
        emit(GetClientCarsSuccessState());
      },
    );
  }

  // --- 5. تحديث دالة close ---
  @override
  Future<void> close() {
    _debounce?.cancel();
    searchController.dispose();

    _debounceCars?.cancel();
    carsSearchController.dispose();

    _debounceVisits?.cancel();
    visitsSearchController.dispose();

    _debounceMaintenance?.cancel();
    maintenanceSearchController.dispose();

    return super.close();
  }
}
