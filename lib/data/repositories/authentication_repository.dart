import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../utils/app_constant.dart';
import '../api/api_client.dart';
import '../models/body/authentication.dart';

class AuthenticationRepository {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthenticationRepository(
      {required this.apiClient, required this.sharedPreferences});

  Future<Response> login(String username, String password) async {
    return await apiClient.postDataNoAuth(
      AppConstant.ENDPOINT_LOGIN,
      body: AuthenticationRequest(
        username: username,
        password: password,
      ),
    );
  }

  Future<Response> introspect() async {
    return await apiClient.postDataNoAuth(AppConstant.ENDPOINT_INTROSPECT);
  }

  Future<bool> saveUserToken(String? token) async {
    apiClient.token = "$token";
    apiClient.updateAuthHeader("$token");
    return await sharedPreferences.setString(AppConstant.TOKEN, "$token");
  }

  Future<String?> getUserToken() async {
    String? token = sharedPreferences.getString(AppConstant.TOKEN);
    if (token != null) {
      apiClient.token = "$token";
      apiClient.updateAuthHeader("$token");
    }
    return token;
  }

  Future<bool> removeToken() async {
    return await sharedPreferences.remove(AppConstant.TOKEN);
  }
}
