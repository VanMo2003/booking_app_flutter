import 'bookedroom_response.dart';
import 'user_response.dart';

class BookingResponse {
  int? id;
  String? bookingDate;
  String? statusOrder;
  String? paymentMethod;
  UserResponse? user;
  BookedRoomResponse? bookedRoom;
  String? onCreate;
  String? onUpdate;

  BookingResponse(
      {this.id,
      this.bookingDate,
      this.statusOrder,
      this.paymentMethod,
      this.user,
      this.bookedRoom,
      this.onCreate,
      this.onUpdate});

  BookingResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingDate = json['bookingDate'];
    statusOrder = json['statusOrder'];
    paymentMethod = json['paymentMethod'];
    user = json['user'] != null ? UserResponse.fromJson(json['user']) : null;
    bookedRoom = json['bookedRoom'] != null
        ? BookedRoomResponse.fromJson(json['bookedRoom'])
        : null;
    onCreate = json['onCreate'];
    onUpdate = json['onUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bookingDate'] = bookingDate;
    data['statusOrder'] = statusOrder;
    data['paymentMethod'] = paymentMethod;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (bookedRoom != null) {
      data['bookedRoom'] = bookedRoom!.toJson();
    }
    data['onCreate'] = onCreate;
    data['onUpdate'] = onUpdate;
    return data;
  }
}
