class AppConstant {
  static const URL_BASE = "http://10.0.2.2:8080/booking-app";
  static const URL_BASE_WEB = "http://localhost:8080/booking-app";

  static const ENDPOINT_LOGIN = "/auth/login";
  static const ENDPOINT_LOGOUT = "/auth/logout";
  static const ENDPOINT_INTROSPECT = "/auth/introspect";
  static const ENDPOINT_REFRESH_TOKEN = "/auth/refreshToken";

  static const ENDPOINT_CREATE_USER = "/user";
  static const ENDPOINT_GET_MY_INFO = "/user/myInfo";
  static const ENDPOINT_CHECK_EXIST_USER = "/user/checkExistUser";

  static const ENDPOINT_GET_ALL_HOTEL = "/hotel";
  static const ENDPOINT_GET_HOTEL_MYSELF = "/hotel/getHotelMySelf";
  static const ENDPOINT_GET_ALL_HOTEL_BY_NAME = "/hotel/search?name=";

  static const ENDPOINT_GET_ALL_ROOM_BY_HOTEL = "/room";
  static const ENDPOINT_CREATE_ROOM = "/room";

  static const ENDPOINT_GET_ALL_SERVICE_BY_HOTEL = "/service";
  static const ENDPOINT_CREATE_SERVICE = "/service";

  static const ENDPOINT_CREATE_ORDER = "/bookedRoom";
  static const ENDPOINT_GET_BOOKING_BY_USER = "/booking/getBookingByUser";
  static const ENDPOINT_GET_BOOKING_BY_HOTEL = "/booking/getBookingByHotel";
  static const ENDPOINT_GET_ORDER_HOTEL = "/booking/hotel";
  static const ENDPOINT_CONFIRM_ORDER = "/booking/confirmOrder";
  static const ENDPOINT_CANCEL_ORDER = "/booking/cancelOrder";

  static const ENDPOINT_CREATE_PAYMENT = "/payment/vn-pay";
  static const ENDPOINT_CALLBACK_PAYMENT = "/payment/vn-pay-callback";

  static const APP_NAME = "Booking App";

  static const LANGUAGE_CODE = "vm_language";
  static const String THEME = 'vm_theme';
  static const String TOKEN = 'vm_token';

  static const List<String> birthPlaces = [
    "An Giang",
    "Hà Giang",
    "Cao Bằng",
    "Lào Cai",
    "Sơn La",
    "Lai Châu",
    "Bắc Kạn",
    "Lạng Sơn",
    "Tuyên Quang",
    "Yên Bái",
    "Thái Nguyên",
    "Điện Biên",
    "Phú Thọ",
    "Vĩnh Phúc",
    "Bắc Giang",
    "Bắc Ninh",
    "Hà Nội",
    "Quảng Ninh",
    "Hải Dương",
    "Hải Phòng",
    "Hòa Bình",
    "Hưng Yên",
    "Hà Nam",
    "Thái Bình",
    "Nam Định",
    "Ninh Bình",
    "Thanh Hóa",
    "Nghệ An",
    "Hà Tĩnh",
    "Quảng Bình",
    "Quảng Trị",
    "Thừa Thiên Huế",
    "Đà Nẵng",
    "Quảng Nam",
    "Quảng Ngãi",
    "Kon Tum",
    "Gia Lai",
    "Bình Định",
    "Phú Yên",
    "Đắk Lắk",
    "Khánh Hòa",
    "Đắk Nông",
    "Lâm Đồng",
    "Ninh Thuận",
    "Bình Phước",
    "Tây Ninh",
    "Bình Dương",
    "Đồng Nai",
    "Bình Thuận",
    "Thành phố Hồ Chí Minh",
    "Long An",
    "Bà Rịa–Vũng Tàu",
    "Đồng Tháp",
    "Tiền Giang",
    "Vĩnh Long",
    "Bến Tre",
    "Cần Thơ",
    "Kiên Giang",
    "Trà Vinh",
    "Hậu Giang",
    "Sóc Trăng",
    "Bạc Liêu",
    "Cà Mau"
  ];
}
