class Hotel {
  String? pathImage;
  String? nameHotel;
  String? address;
  String? description;
  double? price;
  int? numberOfRoom;
  String? userID;

  Hotel({
    this.pathImage,
    this.nameHotel,
    this.address,
    this.description,
    this.price,
    this.numberOfRoom,
    this.userID,
  });

  Hotel.fromJson(Map<String, dynamic> json) {
    pathImage = json['pathImage'];
    nameHotel = json['nameHotel'];
    address = json['address'];
    description = json['description'];
    price = json['price'];
    numberOfRoom = json['numberOfRoom'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pathImage'] = pathImage;
    data['nameHotel'] = nameHotel;
    data['address'] = address;
    data['description'] = description;
    data['price'] = price;
    data['numberOfRoom'] = numberOfRoom;
    data['userID'] = userID;
    return data;
  }
}
