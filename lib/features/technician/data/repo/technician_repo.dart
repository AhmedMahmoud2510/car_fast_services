import 'package:quick_cars_service/barrel.dart';

class HomeTechnicianRepo {
  final ApiServices apiServices;

  HomeTechnicianRepo(this.apiServices);
  Future<Either<Failure, CarMaintenanceRequestsModel>>
  getCarRequestsMaintenance({required String page}) async {
    var response = await apiServices.getCarRequestsMaintenance(page: page);
    if (response?.statusCode == 200) {
      CarMaintenanceRequestsModel data = CarMaintenanceRequestsModel.fromJson(
        response?.data,
      );
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

  Future<Either<Failure, CarMaintenanceRequestsModel>>
  getCarRequestsMaintenanceTechnician({required String page}) async {
    var response = await apiServices.getCarRequestsMaintenanceTechnician(
      page: page,
    );
    if (response?.statusCode == 200) {
      CarMaintenanceRequestsModel data = CarMaintenanceRequestsModel.fromJson(
        response?.data,
      );
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

  Future<Either<Failure, CarMaintenanceRequestsModel>>
  getCarRequestsMaintenanceClient({
    required String page,
    required String clientId,
  }) async {
    var response = await apiServices.getCarRequestsMaintenanceClient(
      page: page,
      clientId: clientId,
    );
    if (response?.statusCode == 200) {
      CarMaintenanceRequestsModel data = CarMaintenanceRequestsModel.fromJson(
        response?.data,
      );
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

  Future<Either<Failure, CarMaintenanceRequestsModel>>
  getCarRequestsMaintenanceCar({
    required String page,
    required String carId,
  }) async {
    var response = await apiServices.getCarRequestsMaintenanceCar(
      page: page,
      carId: carId,
    );
    if (response?.statusCode == 200) {
      CarMaintenanceRequestsModel data = CarMaintenanceRequestsModel.fromJson(
        response?.data,
      );
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

  Future<Either<Failure, RequestDetailsModel>> getRequestDetails({
    required String requestId,
  }) async {
    var response = await apiServices.getRequestDetails(id: requestId);
    if (response?.statusCode == 200) {
      RequestDetailsModel data = RequestDetailsModel.fromJson(response?.data);
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

  Future<Either<Failure, bool>> updateRequest({
    required bool isMaintenance,
    required String requestId,
    // required String desc,
    required String status,
  }) async {
    var response = await apiServices.updateRequestStatus(
      isMaintenance: isMaintenance,
      id: requestId,
      // desc: desc,
      status: status,
    );
    if (response?.statusCode == 200) {
      return right(true);
    } else {
      return left(
        ServerFailure.fromResponse(
          response?.statusCode,
          response!.data['message'],
        ),
      );
    }
  }

  Future<Either<Failure, bool>> deleteRequest({
    required String requestId,
  }) async {
    var response = await apiServices.deleteRequest(requestId: requestId);
    if (response?.statusCode == 200) {
      return right(true);
    } else {
      return left(
        ServerFailure.fromResponse(
          response?.statusCode,
          response!.data['message'],
        ),
      );
    }
  }

  Future<Either<Failure, bool>> addRequest({
    required String carId,
    required List<int> serviceIds,
    required String meterReading,
    required String meterTypeCustom,
  }) async {
    var response = await apiServices.addRequest(
      carId: carId,
      serviceIds: serviceIds,
      meterReading: meterReading,
      meterTypeCustom: meterTypeCustom,
    );
    if (response?.statusCode == 200 || response?.statusCode == 201) {
      return right(true);
    } else {
      return left(
        ServerFailure.fromResponse(
          response?.statusCode,
          response!.data['message'],
        ),
      );
    }
  }

  Future<Either<Failure, CarMaintenanceRequestsModel>> searchRequests({
    required String query,
  }) async {
    var response = await apiServices.search(text: query);
    if (response?.statusCode == 200) {
      CarMaintenanceRequestsModel data = CarMaintenanceRequestsModel.fromJson(
        response?.data,
      );
      return right(data);
    } else {
      return left(
        ServerFailure.fromResponse(
          response?.statusCode,
          response?.data['message'] ?? 'Error occurred',
        ),
      );
    }
  }
}
