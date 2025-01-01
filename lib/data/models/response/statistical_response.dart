class StatisticalResponse {
  int? id;
  String? revenueMonth;
  double? totalRevenue;
  String? onCreate;

  StatisticalResponse(
      {this.id, this.revenueMonth, this.totalRevenue, this.onCreate});

  StatisticalResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    revenueMonth = json['revenueMonth'];
    totalRevenue = json['totalRevenue'];
    onCreate = json['onCreate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['revenueMonth'] = this.revenueMonth;
    data['totalRevenue'] = this.totalRevenue;
    data['onCreate'] = this.onCreate;
    return data;
  }
}