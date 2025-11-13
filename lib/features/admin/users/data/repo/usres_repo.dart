import 'package:quick_cars_service/barrel.dart';

class UsersRepo {
  final ApiServices apiServices;

  UsersRepo(this.apiServices);

  Future<Either<Failure, UsersModel>> getUsers({required String page}) async {
    var response = await apiServices.getUsers(page: page);
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

  Future<Either<Failure, User>> addUser({
    required String name,
    required String password,
    required String role,
    required String phone,
  }) async {
    var response = await apiServices.addUser(
      name: name,
      phone: phone,
      password: password,
      role: role,
    );
    if (response?.statusCode == 200 || response?.statusCode == 201) {
      User data = User.fromJson(response?.data);
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

  Future<Either<Failure, User>> updateUser({
    required String userID,
    required String name,
    required String password,
    String? role,
    required String phone,
  }) async {
    var response = await apiServices.updateUser(
      id: userID,
      name: name,
      phone: phone,
      password: password == '' ? null : password,
      role: role,
    );
    if (response?.statusCode == 200 || response?.statusCode == 201) {
      User data = User.fromJson(response?.data);
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
