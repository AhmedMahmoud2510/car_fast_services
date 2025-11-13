import 'package:quick_cars_service/barrel.dart';

class BrandsRepo {
  final ApiServices apiServices;

  BrandsRepo(this.apiServices);

  Future<Either<Failure, BrandsModel>> getBrands({required String page}) async {
    var response = await apiServices.getBrands(page: page);
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

  Future<Either<Failure, Brand>> addBrand({required String name}) async {
    var response = await apiServices.addBrand(name: name);
    if (response?.statusCode == 200 || response?.statusCode == 201) {
      Brand data = Brand.fromJson(response?.data);
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

  Future<Either<Failure, Brand>> updateBrand({
    required String brandId,
    required String name,
  }) async {
    var response = await apiServices.updateBrand(brandID: brandId, name: name);
    if (response?.statusCode == 200 || response?.statusCode == 201) {
      Brand data = Brand.fromJson(response?.data);
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

  Future<Either<Failure, bool>> deleteBrand({required String brandId}) async {
    var response = await apiServices.deleteBrand(brandId: brandId);
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

  Future<Either<Failure, BrandsModel>> getMake({required String page}) async {
    var response = await apiServices.getMake(page: page);
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

  Future<Either<Failure, Brand>> addMake({required String name}) async {
    var response = await apiServices.addMake(name: name);
    if (response?.statusCode == 200 || response?.statusCode == 201) {
      Brand data = Brand.fromJson(response?.data);
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

  Future<Either<Failure, Brand>> updateMake({
    required String makeID,
    required String name,
  }) async {
    var response = await apiServices.updateMake(makeID: makeID, name: name);
    if (response?.statusCode == 200 || response?.statusCode == 201) {
      Brand data = Brand.fromJson(response?.data);
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

  Future<Either<Failure, bool>> deleteMake({required String makeID}) async {
    var response = await apiServices.deleteMake(makeID: makeID);
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
}
