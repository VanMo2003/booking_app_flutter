import 'package:get/get.dart';

import '../../utils/app_constant.dart';
import '../api/api_client.dart';

class PaymentRepository extends GetxService {
  PaymentRepository({required this.apiClient});
  ApiClient apiClient;

  Future<Response> createPayment(int amount) {
    return apiClient.getData(
      "${AppConstant.ENDPOINT_CREATE_PAYMENT}?amount=$amount&bankCode=NCB",
    );
  }

  Future<Response> callbackPayment(String query) {
    return apiClient.getData("${AppConstant.ENDPOINT_CALLBACK_PAYMENT}?$query");
  }
}
