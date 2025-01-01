class Statistical {
  String? revenueMonth;

  Statistical({this.revenueMonth});

  Statistical.fromJson(Map<String, dynamic> json) {
    revenueMonth = json['revenueMonth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['revenueMonth'] = this.revenueMonth;
    return data;
  }
}