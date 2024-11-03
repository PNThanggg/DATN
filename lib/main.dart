import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_all.dart' as tz;

import 'core/core.dart';
import 'presentation/presentation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharePreferenceUtils.init();

  AppNotificationLocal.initNotificationLocal();
  tz.initializeTimeZones();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 736),
      builder: (context, widget) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.noScaling,
        ),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: AppBinding(),
          initialRoute: AppRoute.splashScreen,
          defaultTransition: Transition.fade,
          getPages: AppPage.pages,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.lightTheme,
          themeMode: ThemeMode.light,
          translations: AppTranslation(),
          supportedLocales: AppConstant.availableLocales,
          locale: AppConstant.availableLocales[1],
          fallbackLocale: AppConstant.availableLocales[0],
        ),
      ),
    );
  }
}
