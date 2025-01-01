import 'package:get/get.dart';

import '../utils/dimensions.dart';

class LoadingController extends GetxController implements GetxService {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loading({required Function() handle}) async {
    _isLoading = true;
    update();

    await Future.delayed(
      const Duration(milliseconds: DimensionUtils.TIME_LOADING_DEFAULT),
      () async {
        await handle();
      },
    );

    noLoading();
  }

  void noLoading() {
    _isLoading = false;
    update();
  }
}
