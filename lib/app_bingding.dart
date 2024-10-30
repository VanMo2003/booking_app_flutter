import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'controller/authentication_controller.dart';
import 'controller/langue_controller.dart';
import 'controller/loading_controller.dart';
import 'data/api/api_client.dart';
import 'data/repositories/authentication_repository.dart';
import 'services/language_service.dart';
import 'theme/theme_controller.dart';
import 'utils/app_constant.dart';

Future<void> binding() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => LanguageService());
  Get.lazyPut(() =>
      ApiClient(urlBase: AppConstant.URL_BASE, sharedPreferences: Get.find()));

  Get.lazyPut(() => AuthenticationRepository(
      apiClient: Get.find(), sharedPreferences: Get.find()));

  Get.lazyPut(() => LoadingController());
  Get.lazyPut(() => LanguageController(sharedPreferences: Get.find()));
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthenticationController(authRepo: Get.find()));
}
