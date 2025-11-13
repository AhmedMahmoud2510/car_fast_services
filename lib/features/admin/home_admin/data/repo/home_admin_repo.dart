import 'package:quick_cars_service/barrel.dart';

class HomeAdminRepo {
  final ApiServices apiServices;

  HomeAdminRepo(this.apiServices);

  Future<Either<Failure, ProductsModel>> getServices({String? page}) async {
    var response = await apiServices.getServices(page: page);
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

  Future<Either<Failure, Product>> addService({
    required String title,
    required String desc,
  }) async {
    var response = await apiServices.addService(title: title, desc: desc);
    if (response?.statusCode == 200 || response?.statusCode == 201) {
      Product data = Product.fromJson(response?.data);
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

  Future<Either<Failure, ProductsModel>> deleteService({
    required String id,
  }) async {
    var response = await apiServices.deleteService(id: id);
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

  Future<Either<Failure, Product>> updateService({
    required String id,
    required String title,
    required String price,
  }) async {
    var response = await apiServices.updateService(
      id: id,
      title: title,
      desc: price,
    );
    if (response?.statusCode == 200) {
      Product data = Product.fromJson(response?.data);
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
}
