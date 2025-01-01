import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../utils/date_convert.dart';
import '../utils/dimensions.dart';
import '../utils/language/key_language.dart';

class ValidationHelper {
  static String? validNull(String? value) {
    if (GetUtils.isNull(value != "" ? value : null)) {
      return KeyLanguage.validNull.tr;
    }
    return null;
  }

  static String? validNumber(String? value) {
    if (GetUtils.isNull(value != "" ? value : null)) {
      return KeyLanguage.validNull.tr;
    }
    if (int.tryParse(value!) == null || int.parse(value) <= 0) {
      return KeyLanguage.validNumber.tr;
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

  static String? validPhoneNumber(String? value) {
    if (GetUtils.isNull(value != "" ? value : null)) {
      return KeyLanguage.validNull.tr;
    }
    if (value!.split("")[0] != "0") {
      return "sdt : 0xxx xxx xxx";
    }
    if (!GetUtils.isLengthBetween(
      value,
      DimensionUtils.PHONE_NUMBER,
      DimensionUtils.PHONE_NUMBER,
    )) {
      return KeyLanguage.validPhoneNumber.tr;
    }
    return null;
  }

  static String? validDOB(String? value) {
    if (GetUtils.isNull(value != "" ? value : null)) {
      return KeyLanguage.validNull.tr;
    }
    try {
      DateFormat dateFormat = DateFormat('dd-MM-yyyy');
      dateFormat.parse(value!);
    } catch (e) {
      return "dd-MM-yyyy";
    }
    int yearNow = int.parse(
      DateConvert.dateTimeToString(DateTime.now()).split("-")[2],
    );
    int yearPick = int.parse(value.split("-")[2]);

    if (yearNow - yearPick < DimensionUtils.AGE_LIMIT) {
      return "tuổi phải lớn hơn ${DimensionUtils.AGE_LIMIT}";
    }
    return null;
  }
}
