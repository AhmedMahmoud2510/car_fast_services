import 'package:quick_cars_service/barrel.dart';



class HomeClientRepo {
  final ApiServices apiServices;

  HomeClientRepo(this.apiServices);

  Future<Either<Failure, ProductsModel>> getServices() async {
    var response = await apiServices.getServices();
    if (response?.statusCode == 200) {
      ProductsModel data = ProductsModel.fromJson(response?.data);
      return right(data);
    } else {
      return left(
        ServerFailure.fromResponse(response?.statusCode, response!.data['message']),
      );
    }
  }
  Future<Either<Failure, ClientCarsModel>> getClientCars({required String id}) async {
    var response = await apiServices.getClientCars(id: id);
    if (response?.statusCode == 200) {
      ClientCarsModel data = ClientCarsModel.fromJson(response?.data);
      return right(data);
    } else {
      return left(
        ServerFailure.fromResponse(response?.statusCode, response!.data['message']),
      );
    }
  }
  Future<Either<Failure, CarVisitsModel>> getCarVisits({required String id}) async {
    var response = await apiServices.getCarVisits(id: id);
    if (response?.statusCode == 200) {
      CarVisitsModel data = CarVisitsModel.fromJson(response?.data);
      return right(data);
    } else {
      return left(
        ServerFailure.fromResponse(response?.statusCode, response!.data['message']),
      );
    }
  }
  Future<Either<Failure, CarMaintenanceModel>> getCarMaintenance({required String id}) async {
    var response = await apiServices.getCarMaintenance(id: id);
    if (response?.statusCode == 200) {
      CarMaintenanceModel data = CarMaintenanceModel.fromJson(response?.data);
      return right(data);
    } else {
      return left(
        ServerFailure.fromResponse(response?.statusCode, response!.data['message']),
      );
    }
  }
}