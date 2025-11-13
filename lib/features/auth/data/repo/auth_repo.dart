import 'package:quick_cars_service/barrel.dart';

class AuthRepo {
  final ApiServices apiServices;

  AuthRepo(this.apiServices);

  Future<Either<Failure, UserModel>> login({
    required String phone,
    required String password,
  }) async {
    var response = await apiServices.login(phone: phone, password: password);
    if (response?.statusCode == 200) {
      UserModel data = UserModel.fromJson(response?.data);
      CacheHelper.saveData(key: CacheKeys.userToken, value: data.data!.token);
      CacheHelper.saveData(key: CacheKeys.userRole, value: data.data!.role);
      CacheHelper.saveData(key: CacheKeys.userId, value: data.data!.id);
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

  Future<Either<Failure, UserModel>> getProfile() async {
    var response = await apiServices.getProfile();
    if (response?.statusCode == 200) {
      UserModel data = UserModel.fromJson(response?.data);
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

  Future<Either<Failure, bool>> logout() async {
    var response = await apiServices.logout();
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
