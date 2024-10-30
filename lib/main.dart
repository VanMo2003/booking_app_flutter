import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_bingding.dart';
import 'helpers/route_helper.dart';
import 'services/language_service.dart';
import 'theme/dark.dart';
import 'theme/light.dart';
import 'theme/theme_controller.dart';
import 'utils/app_constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await binding();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetMaterialApp(
          enableLog: true,
          debugShowCheckedModeBanner: false,
          title: AppConstant.APP_NAME,
          navigatorKey: Get.key,
          theme: themeController.darkTheme ? dark() : light(),
          themeMode: ThemeMode.system,
          locale: LanguageService.locale,
          fallbackLocale: LanguageService.fallbackLocale,
          translations: LanguageService(),
          initialRoute: RouteHelper.getSplashRoute(),
          getPages: RouteHelper.routes,
          defaultTransition: Transition.circularReveal,
          transitionDuration: const Duration(milliseconds: 200),
        );
      },
    );
  }
}
