import 'package:quick_cars_service/barrel.dart';

class CarsRepo {
  final ApiServices apiServices;

  CarsRepo(this.apiServices);

  Future<Either<Failure, BrandsModel>> getBrands() async {
    var response = await apiServices.getBrands();
    if (response?.statusCode == 200) {
      BrandsModel data = BrandsModel.fromJson(response?.data);
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

  Future<Either<Failure, BrandsModel>> getMakes() async {
    var response = await apiServices.getMake();
    if (response?.statusCode == 200) {
      BrandsModel data = BrandsModel.fromJson(response?.data);
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

  Future<Either<Failure, UsersModel>> getUsers() async {
    var response = await apiServices.getUsers(page: 1);
    if (response?.statusCode == 200) {
      UsersModel data = UsersModel.fromJson(response?.data);
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

  Future<Either<Failure, CarsModel>> getCars({required String page}) async {
    var response = await apiServices.getCars(page: page);
    if (response?.statusCode == 200) {
      CarsModel data = CarsModel.fromJson(response?.data);
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

  Future<Either<Failure, Car>> addCar({
    required String brandID,
    required String makeID,
    required String carNumber,
    required String year,
    required String bodyNumber,
    // required String carMeter,
    required String userId,
  }) async {
    var response = await apiServices.addCar(
      brandID: brandID,
      makeID: makeID,
      carNumber: carNumber,
      year: year,
      bodyNumber: bodyNumber,
      // carMeter: carMeter,
      userId: userId,
    );
    if (response?.statusCode == 200 || response?.statusCode == 201) {
      Car data = Car.fromJson(response?.data);
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

  Future<Either<Failure, Car>> updateCar({
    required String carId,
    required String brandID,
    required String makeID,
    required String carNumber,
    required String year,
    required String bodyNumber,
    required String carMeter,
    required String userId,
  }) async {
    var response = await apiServices.updateCar(
      carId: carId,
      brandID: brandID,
      makeID: makeID,
      carNumber: carNumber,
      year: year,
      bodyNumber: bodyNumber,
      carMeter: carMeter,
      userId: userId,
    );
    if (response?.statusCode == 200 || response?.statusCode == 201) {
      Car data = Car.fromJson(response?.data);
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

  Future<Either<Failure, bool>> deleteCar({required String carId}) async {
    var response = await apiServices.deleteCar(id: carId);
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

  Future<Either<Failure, CarsModel>> carsSearch({
    required String carNumber,
  }) async {
    var response = await apiServices.carsSearch(carNumber: carNumber);
    if (response?.statusCode == 200) {
      CarsModel data = CarsModel.fromJson(response?.data);
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
