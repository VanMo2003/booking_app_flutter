import 'package:get/get.dart';

import '../data/models/response/payment_response.dart';
import '../data/repositories/payment_repository.dart';

class PaymentController extends GetxController implements GetxService {
  PaymentController({required this.paymentRepo});

  PaymentRepository paymentRepo;

  PaymentResponse? _paymentResponse;
  PaymentResponse? get paymentResponse => _paymentResponse;

  Future<String?> createPayment(int amount) async {
    Response response = await paymentRepo.createPayment(amount);
    if (response.statusCode == 200) {
      _paymentResponse = PaymentResponse.fromJson(response.body["data"]);

      return _paymentResponse!.paymentUrl;
    } else {
      throw Exception('Failed to create payment');
    }
  }

  Future<int?> callbackPayment(String url) async {
    Response response = await paymentRepo.callbackPayment(url);
    if (response.statusCode == 200) {
      _paymentResponse = PaymentResponse.fromJson(response.body["data"]);
    } else {}

    return response.statusCode!;
  }

  void clearData() {
    _paymentResponse = null;
  }
}
