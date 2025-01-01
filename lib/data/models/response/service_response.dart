class ServiceResponse {
  int? id;
  String? name;
  double? price;
  String? description;

  ServiceResponse({this.id, this.name, this.price, this.description});

  ServiceResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    return data;
  }
}
