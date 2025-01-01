class IntrospectResponse {
  bool? valid;

  IntrospectResponse({this.valid});

  IntrospectResponse.fromJson(Map<String, dynamic> json) {
    valid = json['valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['valid'] = this.valid;
    return data;
  }
}
