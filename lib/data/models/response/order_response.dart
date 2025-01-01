import 'hotel_response.dart';
import 'user_response.dart';

class OrderResponse {
  int? id;
  int? numberOfRoom;
  String? dateCheckIn;
  String? dateCheckOut;
  double? totalPrice;
  String? statusOrder;
  String? paymentMethod;
  UserResponse? user;
  HotelResponse? hotel;
  String? onCreate;
  String? onUpdate;

  OrderResponse(
      {this.id,
      this.numberOfRoom,
      this.dateCheckIn,
      this.dateCheckOut,
      this.totalPrice,
      this.statusOrder,
      this.paymentMethod,
      this.user,
      this.hotel,
      this.onCreate,
      this.onUpdate});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    numberOfRoom = json['numberOfRoom'];
    dateCheckIn = json['dateCheckIn'];
    dateCheckOut = json['dateCheckOut'];
    totalPrice = json['totalPrice'];
    statusOrder = json['statusOrder'];
    paymentMethod = json['paymentMethod'];
    user = json['user'] != null ? UserResponse.fromJson(json['user']) : null;
    hotel =
        json['hotel'] != null ? HotelResponse.fromJson(json['hotel']) : null;
    onCreate = json['onCreate'];
    onUpdate = json['onUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['numberOfRoom'] = numberOfRoom;
    data['dateCheckIn'] = dateCheckIn;
    data['dateCheckOut'] = dateCheckOut;
    data['totalPrice'] = totalPrice;
    data['statusOrder'] = statusOrder;
    data['paymentMethod'] = paymentMethod;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (hotel != null) {
      data['hotel'] = hotel!.toJson();
    }
    data['onCreate'] = onCreate;
    data['onUpdate'] = onUpdate;
    return data;
  }
}
