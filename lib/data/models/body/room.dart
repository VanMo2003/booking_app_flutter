class Room {
  String? name;
  double? price;
  String? description;

  Room({this.name, this.price, this.description});

  Room.fromJson(Map<String, dynamic> json) {
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
