class Order {
  String? paymentMethod;
  String? arrivalDate;
  String? departureDate;
  double? price;
  List<int>? rooms;
  List<int>? services;
  String? note;
  int? hotelId;

  Order(
      {this.paymentMethod,
      this.arrivalDate,
      this.departureDate,
      this.rooms,
      this.price,
      this.services,
      this.note,
      this.hotelId});

  Order.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['paymentMethod'];
    arrivalDate = json['arrivalDate'];
    departureDate = json['departureDate'];
    price = json['price'];
    rooms = json['rooms'].cast<int>();
    services = json['services'].cast<int>();
    note = json['note'];
    hotelId = json['hotelId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentMethod'] = paymentMethod;
    data['arrivalDate'] = arrivalDate;
    data['departureDate'] = departureDate;
    data['price'] = price;
    data['rooms'] = rooms;
    data['services'] = services;
    data['note'] = note;
    data['hotelId'] = hotelId;
    return data;
  }
}
