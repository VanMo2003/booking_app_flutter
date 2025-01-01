import 'package:booking_app_demo/data/repositories/payment_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'controller/authentication_controller.dart';
import 'controller/booking_controller.dart';
import 'controller/calendar_controller.dart';
import 'controller/hotel_controller.dart';
import 'controller/langue_controller.dart';
import 'controller/loading_controller.dart';
import 'controller/payment_controller.dart';
import 'controller/room_controller.dart';
import 'controller/service_controller.dart';
import 'controller/user_controller.dart';
import 'data/api/api_client.dart';
import 'data/repositories/authentication_repository.dart';
import 'data/repositories/hotel_repository.dart';
import 'data/repositories/order_repository.dart';
import 'data/repositories/room_repository.dart';
import 'data/repositories/service_repository.dart';
import 'data/repositories/user_repository.dart';
import 'services/language_service.dart';
import 'theme/theme_controller.dart';
import 'utils/app_constant.dart';

Future<void> binding() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => LanguageService());
  Get.lazyPut(() =>
      ApiClient(urlBase: AppConstant.URL_BASE, sharedPreferences: Get.find()));

  Get.lazyPut(() => AuthenticationRepository(
      apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      UserRepository(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      HotelRepository(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      BookingRepository(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => RoomRepository(apiClient: Get.find()));
  Get.lazyPut(() => ServiceRepository(apiClient: Get.find()));
  Get.lazyPut(() => PaymentRepository(apiClient: Get.find()));

  Get.lazyPut(() => LoadingController());
  Get.lazyPut(() => LanguageController(sharedPreferences: Get.find()));
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthenticationController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => HotelController(hotelRepo: Get.find()));
  Get.lazyPut(() => RoomController(roomRepo: Get.find()));
  Get.lazyPut(() => ServiceController(serviceRepo: Get.find()));
  Get.lazyPut(() => BookingController(bookingRepo: Get.find()));
  Get.lazyPut(() => PaymentController(paymentRepo: Get.find()));
  Get.lazyPut(() => CalendarController());
}
