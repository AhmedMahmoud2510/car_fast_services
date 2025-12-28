import 'package:quick_cars_service/barrel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3460), () {
      _route();
    });
  }

  String? userRole;
  Future<bool> isLoggedIn() async {
    String? token = await CacheHelper.getData(key: CacheKeys.userToken);
    userRole = await CacheHelper.getData(key: CacheKeys.userRole);
    debugPrintWidget(token);
    debugPrintWidget(userRole);
    return token != null ? true : false;
  }

  Future<void> _route() async {
    if (await isLoggedIn()) {
      if (userRole == 'admin') {
        context.pushReplacementNamed(
          Routes.homeTechnicianScreen,
          arguments: '',
        );
      } else if (userRole == 'client') {
        // context.pushReplacementNamed(Routes.homeClientScreen);
        context.pushReplacementNamed(
          Routes.clientCarsScreen,
          arguments: '${await CacheHelper.getData(key: CacheKeys.userId)}',
        );
      } else if (userRole == 'technician') {
        context.pushReplacementNamed(
          Routes.homeTechnicianScreen,
          arguments: '',
        );
      } else if (userRole == 'reception') {
        context.pushReplacementNamed(Routes.carsScreen, arguments: true);
      }
    } else {
      context.pushReplacementNamed(Routes.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Center(
        child: Image.asset(
          Assets.logo,
          width: 400.w,
          fit: BoxFit.fitWidth,
        ), // Add your GIF to assets.
      ),
      bottomNavigationBar: const PoweredByWidget(),
    );
  }
}
