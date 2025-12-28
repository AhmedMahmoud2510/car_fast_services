import 'package:quick_cars_service/barrel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  await EasyLocalization.ensureInitialized();

  await DioFactory.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(
    EasyLocalization(
      useFallbackTranslations: true,
      fallbackLocale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      path: 'assets/languages',
      child: Phoenix(child: QuickCarsServiceApp(appRouter: AppRouter())),
    ),
  );
}

class QuickCarsServiceApp extends StatelessWidget {
  final AppRouter appRouter;
  const QuickCarsServiceApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
      child: MaterialApp(
        title: 'Quick Cars Service',
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        theme: lightTheme,
        darkTheme: lightTheme,
        themeMode: ThemeMode.light,
        initialRoute: Routes.splashScreen,
        onGenerateRoute: appRouter.generateRoute,
        builder: (context, myWidget) {
          configLoading(context);
          return myWidget = EasyLoading.init()(context, myWidget);
        },
      ),
    );
  }
}
