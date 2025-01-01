import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/user_controller.dart';
import '../../utils/app_constant.dart';
import '../api/api_client.dart';
import '../models/body/order.dart';

class BookingRepository extends GetxService {
  BookingRepository({required this.apiClient, required this.sharedPreferences});

  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  Future<Response> createOrder(Order order) async {
    return await apiClient.postData(
      AppConstant.ENDPOINT_CREATE_ORDER,
      order,
    );
  }

  Future<Response> getBookingMyself() async {
    return await apiClient.getData(
        Get.find<UserController>().role == Role.hotelier
            ? AppConstant.ENDPOINT_GET_BOOKING_BY_HOTEL
            : AppConstant.ENDPOINT_GET_BOOKING_BY_USER);
  }

  Future<Response> getOrderHotel() async {
    return await apiClient.getData(AppConstant.ENDPOINT_GET_ORDER_HOTEL);
  }

  Future<Response> confirmOrder(int orderId) async {
    return await apiClient
        .putData("${AppConstant.ENDPOINT_CONFIRM_ORDER}/$orderId");
  }

  Future<Response> cancelOrder(int orderId) async {
    return await apiClient
        .putData("${AppConstant.ENDPOINT_CANCEL_ORDER}/$orderId");
  }
}
