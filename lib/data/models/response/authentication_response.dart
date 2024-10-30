class AuthenticationResponse {
  bool? authenticated;
  String? token;

  AuthenticationResponse({this.authenticated, this.token});

  AuthenticationResponse.fromJson(Map<String, dynamic> json) {
    authenticated = json['authenticated'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authenticated'] = this.authenticated;
    data['token'] = this.token;
    return data;
  }
}
