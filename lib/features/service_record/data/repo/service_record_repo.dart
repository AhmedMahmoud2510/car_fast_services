import 'package:quick_cars_service/barrel.dart';
import 'package:quick_cars_service/features/service_record/data/model/service_record_model.dart';

class ServiceRecordRepo {
  final ApiServices apiServices;

  ServiceRecordRepo(this.apiServices);

  Future<Either<Failure, ProductsModel>> getServices() async {
    var response = await apiServices.getServices();
    if (response?.statusCode == 200) {
      ProductsModel data = ProductsModel.fromJson(response?.data);
      return right(data);
    } else {
      return left(
        ServerFailure.fromResponse(
          response?.statusCode,
          response!.data['message'],
        ),
      );
    }
  }

  Future<Either<Failure, MaintenanceResponse>> getClientMaintenanceRequests({
    required String clientId,
  }) async {
    var response = await apiServices.getServiceRecord(
      clientId: clientId,
    );

    if (response?.statusCode == 200) {
      MaintenanceResponse data = MaintenanceResponse.fromJson(response!.data);
      return right(data);
    } else {
      return left(
        ServerFailure.fromResponse(
          response?.statusCode,
          response?.data['message'],
        ),
      );
    }
  }

}
