import 'dart:developer';

import 'package:get/get.dart';

import '../data/api/api_checker.dart';
import '../data/models/response/api_response.dart';
import '../data/models/response/authentication_response.dart';
import '../data/models/response/introspect_response.dart';
import '../data/repositories/authentication_repository.dart';

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
      setStatus(AuthenticationStatus.authentication);

      AuthenticationResponse? authentication =
          AuthenticationResponse.fromJson(res.data);

      if (authentication.token != null) {
        authRepo.saveUserToken(authentication.token);
      }
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }

    log(response.statusCode!.toString());

    return response.statusCode!;
  }

  Future<bool> introspect() async {
    Response response = await authRepo.introspect();

    bool valid =
        IntrospectResponse.fromJson(response.body["data"]).valid ?? false;

    return valid;
  }

  void setStatus(AuthenticationStatus status) {
    _status = status;
    update();
  }

  void clearData() {
    _status = AuthenticationStatus.un_authentication;
  }
}
