import 'hotel_response.dart';
import 'room_response.dart';
import 'service_response.dart';

class BookedRoomResponse {
  int? id;
  String? arrivalDate;
  String? departureDate;
  List<RoomResponse>? rooms;
  List<ServiceResponse>? services;
  double? price;
  String? note;
  HotelResponse? hotel;
  String? onCreate;
  String? onUpdate;
  bool? checkedIn;
  bool? checkedOut;

  BookedRoomResponse(
      {this.id,
      this.arrivalDate,
      this.departureDate,
      this.rooms,
      this.services,
      this.price,
      this.note,
      this.hotel,
      this.onCreate,
      this.onUpdate,
      this.checkedIn,
      this.checkedOut});

  BookedRoomResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arrivalDate = json['arrivalDate'];
    departureDate = json['departureDate'];
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
    price = json['price'];
    note = json['note'];
    hotel =
        json['hotel'] != null ? HotelResponse.fromJson(json['hotel']) : null;
    onCreate = json['onCreate'];
    onUpdate = json['onUpdate'];
    checkedIn = json['checkedIn'];
    checkedOut = json['checkedOut'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['arrivalDate'] = arrivalDate;
    data['departureDate'] = departureDate;
    if (rooms != null) {
      data['rooms'] = rooms!.map((v) => v.toJson()).toList();
    }
    if (services != null) {
      data['services'] = services!.map((v) => v.toJson()).toList();
    }
    data['price'] = price;
    data['note'] = note;
    if (hotel != null) {
      data['hotel'] = hotel!.toJson();
    }
    data['onCreate'] = onCreate;
    data['onUpdate'] = onUpdate;
    data['checkedIn'] = checkedIn;
    data['checkedOut'] = checkedOut;
    return data;
  }
}
