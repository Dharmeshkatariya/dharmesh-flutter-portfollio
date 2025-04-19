import 'package:get/get.dart';

import '../web/dashboard/dashboard_home_view.dart';
import '../web/splash/splash_view.dart';
import 'bindings.dart';

class Routes {
  String initialRoute = '/';
  String homeScreen = '/home';

  Map<String, String> get routeDisplayNames => {
        initialRoute: '/',
        homeScreen: 'Home',
      };

  Map<String, String> get providerInternalRoutes => {};

  appRoutes() => [
        GetPage(
            name: initialRoute,
            page: () => const SplashView(),
            binding: AppBindings()),
        GetPage(
            name: homeScreen,
            page: () => const DashboardHomeView(),
            binding: AppBindings()),
      ];
}
