import 'package:quick_cars_service/barrel.dart';



final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<ApiServices>(() => ApiServices(DioFactory()));
// ! -------------------------------------------------------------------

  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepo(getIt()));
  getIt.registerFactory<HomeAdminCubit>(() => HomeAdminCubit(getIt()));
  getIt.registerFactory<HomeAdminRepo>(() => HomeAdminRepo(getIt()));
  getIt.registerFactory<UsersCubit>(() => UsersCubit(getIt()));
  getIt.registerFactory<UsersRepo>(() => UsersRepo(getIt()));
  getIt.registerFactory<CarsCubit>(() => CarsCubit(getIt()));
  getIt.registerFactory<CarsRepo>(() => CarsRepo(getIt()));
  getIt.registerFactory<BrandsCubit>(() => BrandsCubit(getIt()));
  getIt.registerFactory<BrandsRepo>(() => BrandsRepo(getIt()));
  getIt.registerFactory<ChatCubit>(() => ChatCubit(getIt()));
  getIt.registerFactory<ChatRepo>(() => ChatRepo(getIt()));
  getIt.registerFactory<HomeClientCubit>(() => HomeClientCubit(getIt()));
  getIt.registerFactory<HomeClientRepo>(() => HomeClientRepo(getIt()));
  getIt.registerFactory<HomeTechnicianCubit>(() => HomeTechnicianCubit(getIt()));
  getIt.registerFactory<HomeTechnicianRepo>(() => HomeTechnicianRepo(getIt()));

}
