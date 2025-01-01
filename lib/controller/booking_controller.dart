import 'package:get/get.dart';

import '../data/api/api_checker.dart';
import '../data/models/body/order.dart';
import '../data/models/response/api_response.dart';
import '../data/models/response/booking_response.dart';
import '../data/repositories/order_repository.dart';

enum OrderStatus { pending, cancel, complete, confirm }

class BookingController extends GetxController implements GetxService {
  BookingController({required this.bookingRepo});

  final BookingRepository bookingRepo;

  List<BookingResponse>? _booking;

  List<BookingResponse>? get bookings => _booking;

  Future<int> createOrder(Order order) async {
    Response response = await bookingRepo.createOrder(order);

    ApiResponse apiResponse = ApiResponse.fromJson(response.body);
    if (response.statusCode == 200) {
      if (_booking != null) {
        BookingResponse booking = BookingResponse.fromJson(apiResponse.data);
        _booking!.insert(0, booking);
      }
    } else {
      // ApiChecker.apiChecker(apiResponse.code!);
    }

    return response.statusCode!;
  }

  Future<int> getBookingMyself() async {
    Response response = await bookingRepo.getBookingMyself();

    if (response.statusCode == 200) {
      _booking ??= [];

      for (var hotel in response.body["data"]) {
        _booking!.add(BookingResponse.fromJson(hotel));
      }
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }

    update();

    return response.statusCode!;
  }

  Future<int> getOrderHotel() async {
    Response response = await bookingRepo.getOrderHotel();

    if (response.statusCode == 200) {
      _booking ??= [];

      for (var hotel in response.body["data"]) {
        _booking!.add(BookingResponse.fromJson(hotel));
      }
      update();
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }

    return response.statusCode!;
  }

  Future<int> confirmOrder(int orderId) async {
    Response response = await bookingRepo.confirmOrder(orderId);

    if (response.statusCode == 200) {
      updateStatus(orderId, true);
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }

    return response.statusCode!;
  }

  Future<int> cancelOrder(int orderId) async {
    Response response = await bookingRepo.cancelOrder(orderId);

    if (response.statusCode == 200) {
      updateStatus(orderId, false);
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }

    return response.statusCode!;
  }

  void updateStatus(int orderId, bool isConfirm) {
    for (var order in _booking!) {
      if (order.id == orderId) {
        if (isConfirm) {
          order.statusOrder = "CONFIRMED";
        } else {
          order.statusOrder = "CANCELED";
        }
        update();
      }
    }
  }

  void sortOrderOfHotel() {
    _booking!.sort(
      (a, b) {
        if (a.statusOrder == 'PENDING' && b.statusOrder != 'PENDING') {
          return -1;
        } else if (a.statusOrder != 'PENDING' && b.statusOrder == 'PENDING') {
          return 1;
        } else {
          return 0;
        }
      },
    );

    update();
  }

  clearData() {
    _booking = null;
  }
}
