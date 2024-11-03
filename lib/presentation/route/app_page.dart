import 'package:get/get.dart';


import '../screen/splash/splash_binding.dart';
import '../screen/splash/splash_screen.dart';

import 'app_route.dart';

class AppPage {
  AppPage._();

  static final pages = [
    GetPage(
      name: AppRoute.splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
  ];
}
