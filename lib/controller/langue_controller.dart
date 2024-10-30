import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/language_service.dart';
import '../utils/app_constant.dart';

class LanguageController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;

  LanguageController({required this.sharedPreferences});

  Future<bool> changeLocale(String langCode) async {
    LanguageService.changeLocale(langCode);

    return await sharedPreferences.setString(
        AppConstant.LANGUAGE_CODE, langCode);
  }

  String getLocale() {
    return sharedPreferences.getString(AppConstant.LANGUAGE_CODE) ?? "vi";
  }
}
