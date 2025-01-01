class Service {
  String? name;
  double? price;
  String? description;

  Service({this.name, this.price, this.description});

  Service.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    return data;
  }
}
