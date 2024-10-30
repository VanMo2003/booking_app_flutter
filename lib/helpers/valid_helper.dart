import 'package:get/get.dart';

import '../utils/dimensions.dart';
import '../utils/language/key_language.dart';

class ValidationHelper {
  static String? validNull(String? value) {
    if (GetUtils.isNull(value != "" ? value : null)) {
      return KeyLanguage.validNull.tr;
    }
    return null;
  }

  static String? validPassword(String? value) {
    if (GetUtils.isNull(value != "" ? value : null)) {
      return KeyLanguage.validNull.tr;
    }
    if (!GetUtils.isLengthBetween(
      value!,
      DimensionUtils.MIN_LENGTH_PASSWORD,
      DimensionUtils.MAX_LENGTH_PASSWORD,
    )) {
      return KeyLanguage.validPassword.tr;
    }
    return null;
  }
}
