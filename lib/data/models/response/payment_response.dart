class PaymentResponse {
  String? code;
  String? message;
  String? paymentUrl;

  PaymentResponse({this.code, this.message, this.paymentUrl});

  PaymentResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    paymentUrl = json['paymentUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['paymentUrl'] = paymentUrl;
    return data;
  }
}
