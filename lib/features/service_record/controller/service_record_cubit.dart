import 'package:quick_cars_service/barrel.dart';
import 'package:quick_cars_service/features/service_record/data/model/service_record_model.dart'
    as sr;
import 'package:quick_cars_service/features/service_record/data/repo/service_record_repo.dart';

part 'service_record_state.dart';

class ServiceRecordCubit extends Cubit<ServiceRecordState> {
  ServiceRecordCubit(this._repo) : super(ServiceRecordInitial());

  final ServiceRecordRepo _repo;

  sr.MaintenanceResponse? maintenanceResponse;

  List<sr.Product> displayedServices = [];
  List<sr.Product> _allServices = [];

  final TextEditingController maintenanceRequestsSearchController =
      TextEditingController();

  Timer? _debounce;

  Future<void> getClientMaintenanceRequests({required String clientId}) async {
    emit(GetServiceRecordLoadingState());

    final result = await _repo.getClientMaintenanceRequests(clientId: clientId);

    result.fold((l) => emit(GetServiceRecordFailedState()), (
      sr.MaintenanceResponse model,
    ) {
      maintenanceResponse = model;

      final Map<int, sr.Product> uniqueServices = {};

      for (final request in model.data) {
        for (final item in request.maintenances) {
          uniqueServices[item.product.id] = item.product;
        }
      }

      _allServices = uniqueServices.values.toList();
      displayedServices = List.from(_allServices);

      emit(GetServiceRecordSuccessState());
    });
  }

  void onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 300),
      () => _filterByName(query),
    );
  }

  void _filterByName(String query) {
    if (query.isEmpty) {
      displayedServices = List.from(_allServices);
    } else {
      final q = query.toLowerCase();
      displayedServices = _allServices
          .where((s) => s.name.toLowerCase().contains(q))
          .toList();
    }

    emit(GetServiceRecordSuccessState());
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    maintenanceRequestsSearchController.dispose();
    return super.close();
  }
}
