import 'package:quick_cars_service/barrel.dart';


class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.splashScreen:
        return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.loginScreen:
        return PageTransition(
          child: BlocProvider(
            create: (context) => AuthCubit(getIt()),
            child: const LoginScreen(),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.homeAdminScreen:
        return PageTransition(
          child: BlocProvider(
            create: (context) =>
                HomeAdminCubit(getIt())..getServices(isPaginate: true),
            child: const AdminHomeScreen(),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.profileScreen:
        return PageTransition(
          child: BlocProvider(
            create: (context) => AuthCubit(getIt())..getProfile(),
            child: const ProfileScreen(),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.usersScreen:
        final bool isReception = settings.arguments as bool;
        return PageTransition(
          child: BlocProvider(
            create: (context) => UsersCubit(getIt())..getUsers(),
            child: UsersScreen(isReception: isReception),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.allChatScreen:
        return PageTransition(
          child: BlocProvider(
            create: (context) => ChatCubit(getIt())..getChats(),
            child: const AllChatsScreen(),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.chatScreen:
        final ChatScreenModel data = settings.arguments as ChatScreenModel;
        return PageTransition(
          child: BlocProvider(
            create: (context) =>
                ChatCubit(getIt())
                  ..getChatDetails(userId: '${data.receiverId}'),
            child: ChatScreen(data: data),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.carsScreen:
        final bool isReception = settings.arguments as bool;
        return PageTransition(
          child: BlocProvider(
            create: (context) => CarsCubit(getIt())..getCars(),
            child: CarsScreen(isReception: isReception),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.brandsScreen:
        return PageTransition(
          child: BlocProvider(
            create: (context) => BrandsCubit(getIt())..getBrands(),
            child: const BrandsScreen(),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.homeClientScreen:
        return PageTransition(
          child: BlocProvider(
            create: (context) => HomeClientCubit(getIt())..getServices(),
            child: const ClientHomeScreen(),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.clientCarsScreen:
        final String userId = settings.arguments as String;
        return PageTransition(
          child: BlocProvider(
            create: (context) =>
                HomeClientCubit(getIt())..getClientCars(userId: userId),
            child: const ClientCarsScreen(),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.carVisitsScreen:
        final int carId = settings.arguments as int;
        return PageTransition(
          child: BlocProvider(
            create: (context) =>
                HomeClientCubit(getIt())..getCarVisits(carID: '$carId'),
            child: const CarVisitsScreen(),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.invoiceScreen:
        final String invoiceId = settings.arguments as String;
        return PageTransition(
          child: BlocProvider(
            create: (context) => HomeTechnicianCubit(getIt()),
            child: InvoiceWebViewScreen(invoiceId: invoiceId),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.carMaintenanceScreen:
        final int visitId = settings.arguments as int;
        return PageTransition(
          child: BlocProvider(
            create: (context) =>
                HomeClientCubit(getIt())
                  ..getCarMaintenance(visitId: '$visitId'),
            child: const CarMaintenanceScreen(),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.homeTechnicianScreen:
        final String carId = settings.arguments as String;
        return PageTransition(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    HomeTechnicianCubit(getIt())
                      ..getCarRequestsMaintenance(carId: carId),
              ),
              BlocProvider(create: (context) => HomeAdminCubit(getIt())),
            ],
            child: const TechnicianHomeScreen(),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      case Routes.requestDetailsScreen:
        final int index = settings.arguments as int;
        return PageTransition(
          child: BlocProvider(
            create: (context) =>
                HomeTechnicianCubit(getIt())..getCarRequestsMaintenance(),
            // ..getRequestDetails(requestId: '$requestId')
            child: RequestDetailsScreen(index: index),
          ),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );
      default:
        null;
    }
    return null;
  }
}
