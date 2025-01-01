import 'room_response.dart';
import 'service_response.dart';
import 'user_response.dart';

class HotelResponse {
  int? id;
  String? pathImage;
  String? nameHotel;
  String? address;
  String? description;
  double? rating;
  UserResponse? user;
  List<RoomResponse>? rooms;
  List<ServiceResponse>? services;
  bool? active;
  String? onCreate;
  String? onUpdate;

  HotelResponse({
    this.id,
    this.pathImage,
    this.nameHotel,
    this.address,
    this.description,
    this.rating,
    this.user,
    this.active,
    this.onCreate,
    this.onUpdate,
  });

  HotelResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pathImage = json['pathImage'];
    nameHotel = json['nameHotel'];
    address = json['address'];
    description = json['description'];
    rating = json['rating'];
    user = json['user'] != null ? UserResponse.fromJson(json['user']) : null;
    if (json['rooms'] != null) {
      rooms = <RoomResponse>[];
      json['rooms'].forEach((v) {
        rooms!.add(RoomResponse.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = <ServiceResponse>[];
      json['services'].forEach((v) {
        services!.add(ServiceResponse.fromJson(v));
      });
    }
    active = json['active'];
    onCreate = json['onCreate'];
    onUpdate = json['onUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pathImage'] = pathImage;
    data['nameHotel'] = nameHotel;
    data['address'] = address;
    data['description'] = description;
    data['rating'] = rating;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (rooms != null) {
      data['rooms'] = rooms!.map((v) => v.toJson()).toList();
    }
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    data['active'] = active;
    data['onCreate'] = onCreate;
    data['onUpdate'] = onUpdate;
    return data;
  }
}
