import '../body/user.dart';

class HotelResponse {
  String? pathImage;
  String? nameHotel;
  String? address;
  String? description;
  double? price;
  int? numberOfRoom;
  User? user;
  bool? active;
  String? onCreate;
  String? onUpdate;

  HotelResponse({
    this.pathImage,
    this.nameHotel,
    this.address,
    this.description,
    this.price,
    this.numberOfRoom,
    this.user,
    this.active,
    this.onCreate,
    this.onUpdate,
  });

  HotelResponse.fromJson(Map<String, dynamic> json) {
    pathImage = json['pathImage'];
    nameHotel = json['nameHotel'];
    address = json['address'];
    description = json['description'];
    price = json['price'];
    numberOfRoom = json['numberOfRoom'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    active = json['active'];
    onCreate = json['onCreate'];
    onUpdate = json['onUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pathImage'] = pathImage;
    data['nameHotel'] = nameHotel;
    data['address'] = address;
    data['description'] = description;
    data['price'] = price;
    data['numberOfRoom'] = numberOfRoom;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['active'] = active;
    data['onCreate'] = onCreate;
    data['onUpdate'] = onUpdate;
    return data;
  }
}
