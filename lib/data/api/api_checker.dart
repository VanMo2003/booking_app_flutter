import 'package:get/get.dart';

import '../../utils/language/key_language.dart';
import '../../views/custom_snackbar.dart';

class ApiChecker {
  static void apiChecker(int statusCode) {
    if (statusCode == 401) {
      showCustomSnackBar(
        KeyLanguage.errorUnauthentication.tr,
        isError: true,
      );
    } else if (statusCode == 404) {
      showCustomSnackBar(
        KeyLanguage.errorWrongUsernameOrPassword.tr,
        isError: true,
      );
    } else {
      showCustomSnackBar(
        KeyLanguage.errorSystem.tr,
        isError: true,
      );
    }
  }
}
