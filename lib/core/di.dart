import 'package:quick_cars_service/barrel.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<ApiServices>(() => ApiServices(DioFactory()));
  // ! -------------------------------------------------------------------

  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepo(getIt()));
  getIt.registerFactory<HomeAdminCubit>(() => HomeAdminCubit(getIt()));
  getIt.registerLazySingleton<HomeAdminRepo>(() => HomeAdminRepo(getIt()));
  getIt.registerFactory<UsersCubit>(() => UsersCubit(getIt()));
  getIt.registerLazySingleton<UsersRepo>(() => UsersRepo(getIt()));
  getIt.registerFactory<CarsCubit>(() => CarsCubit(getIt()));
  getIt.registerLazySingleton<CarsRepo>(() => CarsRepo(getIt()));
  getIt.registerFactory<BrandsCubit>(() => BrandsCubit(getIt()));
  getIt.registerLazySingleton<BrandsRepo>(() => BrandsRepo(getIt()));
  getIt.registerFactory<ChatCubit>(() => ChatCubit(getIt()));
  getIt.registerLazySingleton<ChatRepo>(() => ChatRepo(getIt()));
  getIt.registerFactory<HomeClientCubit>(() => HomeClientCubit(getIt()));
  getIt.registerLazySingleton<HomeClientRepo>(() => HomeClientRepo(getIt()));
  getIt.registerFactory<HomeTechnicianCubit>(
    () => HomeTechnicianCubit(getIt()),
  );
  getIt.registerLazySingleton<HomeTechnicianRepo>(
    () => HomeTechnicianRepo(getIt()),
  );
}
