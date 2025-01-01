import 'dart:developer';

import 'package:get/get.dart';
import '../data/api/api_checker.dart';
import '../data/models/response/api_response.dart';
import '../data/models/response/authentication_response.dart';
import '../data/models/response/introspect_response.dart';
import '../data/repositories/authentication_repository.dart';
import 'booking_controller.dart';
import 'calendar_controller.dart';
import 'hotel_controller.dart';
import 'user_controller.dart';

enum AuthenticationStatus { authentication, un_authentication, unknown }

class AuthenticationController extends GetxController implements GetxService {
  final AuthenticationRepository authRepo;

  AuthenticationController({required this.authRepo});

  AuthenticationStatus _status = AuthenticationStatus.un_authentication;
  AuthenticationStatus get status => _status;

  Future<int> login(String username, String password) async {
    Response response = await authRepo.login(username, password);
    ApiResponse res = ApiResponse.fromJson(response.body);

    if (response.statusCode == 200) {
      AuthenticationResponse? authentication =
          AuthenticationResponse.fromJson(res.data);

      if (authentication.token != null) {
        authRepo.saveUserToken(authentication.token);
      }
      setStatus(AuthenticationStatus.authentication);
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }

    log(response.statusCode!.toString());

    update();

    return response.statusCode!;
  }

  Future<bool> introspect() async {
    Response response = await authRepo.introspect();

    bool valid =
        IntrospectResponse.fromJson(response.body["data"]).valid ?? false;

    return valid;
  }

  Future<int> refreshToken() async {
    Response response = await authRepo.refreshToken();

    ApiResponse res = ApiResponse.fromJson(response.body);

    if (response.statusCode == 200) {
      AuthenticationResponse? authentication =
          AuthenticationResponse.fromJson(res.data);

      if (authentication.token != null) {
        authRepo.saveUserToken(authentication.token);
      }
      setStatus(AuthenticationStatus.authentication);
    } else {
      setStatus(AuthenticationStatus.un_authentication);
    }

    return response.statusCode!;
  }

  Future<int> logout() async {
    Response response = await authRepo.logout();

    if (response.statusCode == 200) {
      authRepo.removeToken();
      clearData();
    }

    update();

    return response.statusCode!;
  }

  void setStatus(AuthenticationStatus status) {
    _status = status;
    update();
  }

  void clearData() {
    Get.find<UserController>().clearData();
    Get.find<BookingController>().clearData();
    Get.find<HotelController>().clearData();
    Get.find<CalendarController>().clearData();
    _status = AuthenticationStatus.un_authentication;
  }
}
