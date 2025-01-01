import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constant.dart';
import '../api/api_client.dart';

class HotelRepository extends GetxService {
  HotelRepository({required this.apiClient, required this.sharedPreferences});

  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  Future<Response> getAllHotel() async {
    return await apiClient.getData(AppConstant.ENDPOINT_GET_ALL_HOTEL);
  }

  Future<Response> getHotelMySelf() async {
    return await apiClient.getData(AppConstant.ENDPOINT_GET_HOTEL_MYSELF);
  }

  Future<Response> getAllHotelByName(String nameHotel) async {
    return await apiClient.getData(
      "${AppConstant.ENDPOINT_GET_ALL_HOTEL_BY_NAME}$nameHotel",
    );
  }
}
