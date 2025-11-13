import 'package:quick_cars_service/barrel.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepo) : super(AuthInitial());
  final AuthRepo _authRepo;

  UserModel? userModel;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<void> login() async {
    showLoading();
    emit(LoginLoadingState());
    final result = await _authRepo.login(
      phone: phoneController.text,
      password: passwordController.text,
    );
    result.fold(
      (l) {
        hideLoading();
        emit(LoginFailedState());
      },
      (model) {
        hideLoading();
        userModel = model;
        emit(LoginSuccessState());
      },
    );
  }

  UserModel? profileModel;
  Future<void> getProfile() async {
    showLoading();
    emit(GetProfileLoadingState());
    final result = await _authRepo.getProfile();
    result.fold(
      (l) {
        hideLoading();
        emit(GetProfileFailedState());
      },
      (model) {
        hideLoading();
        profileModel = model;
        emit(GetProfileSuccessState());
      },
    );
  }

  Future<bool> logout() async {
    showLoading();
    emit(LogoutLoadingState());

    final result = await _authRepo.logout();

    return result.fold(
      (failure) {
        hideLoading();
        emit(LogoutFailedState());
        return false;
      },
      (model) {
        hideLoading();
        emit(LogoutSuccessState());
        return true;
      },
    );
  }
}
