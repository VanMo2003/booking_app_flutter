import 'dart:collection';
import 'dart:ui';
import 'package:get/get.dart';

import '../controller/langue_controller.dart';
import '../utils/language/st_en_us.dart';
import '../utils/language/st_vi_vn.dart';

class LanguageService extends Translations {
  // locale sẽ được get mỗi khi mới mở app (phụ thuộc vào locale hệ thống hoặc bạn có thể cache lại locale mà người dùng đã setting và set nó ở đây)
  static final locale = _getLocaleFromLanguage();

  // fallbackLocale là locale default nếu locale được set không nằm trong những Locale support
  static const fallbackLocale = Locale('vi', 'VN');

  // language code của những locale được support
  static final langCodes = [
    'vi',
    'en',
  ];

  // các Locale được support
  static const locales = [
    Locale('vi', 'VN'),
    Locale('en', 'US'),
  ];

  // cái này là Map các language được support đi kèm với mã code của lang đó: cái này dùng để đổ data vào Dropdownbutton và set language mà không cần quan tâm tới language của hệ thống
  static final langs = LinkedHashMap.from({
    'vi': 'Tiếng Việt',
    'en': 'English',
  });

  // function change language nếu bạn không muốn phụ thuộc vào ngôn ngữ hệ thống
  static void changeLocale(String langCode) {
    final locale = _getLocaleFromLanguage(langCode: langCode);
    Get.updateLocale(locale!);
  }

  static Locale? _getLocaleFromLanguage({String? langCode}) {
    var lang = langCode ?? Get.find<LanguageController>().getLocale();
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) return locales[i];
    }
    return Get.locale;
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'vi_VN': vi,
        'en_US': en,
      };
}
