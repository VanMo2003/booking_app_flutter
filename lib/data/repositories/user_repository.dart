import 'package:booking_app_demo/data/models/body/user_update.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_constant.dart';
import '../api/api_client.dart';
import '../models/body/user.dart';

class UserRepository {
  UserRepository({
    required this.apiClient,
    required this.sharedPreferences,
  });

  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  Future<Response> createUser(User user) async {
    return await apiClient.postDataNoAuth(
      AppConstant.ENDPOINT_CREATE_USER,
      body: user,
    );
  }

  Future<Response> getMyInfo() async {
    return await apiClient.getData(AppConstant.ENDPOINT_GET_MY_INFO);
  }

  Future<Response> updateMyInfo(UserUpdate userNew) async {
    return await apiClient.putData(
      AppConstant.ENDPOINT_UPDATE_MY_INFO,
      body: userNew,
    );
  }

  Future<Response> checkExistUser(String username) async {
    return await apiClient
        .getDataNoAuth("${AppConstant.ENDPOINT_CHECK_EXIST_USER}/$username");
  }

  String? getUserToken() {
    return sharedPreferences.getString(AppConstant.TOKEN);
  }
}
