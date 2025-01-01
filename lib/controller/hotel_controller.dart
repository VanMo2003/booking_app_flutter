import 'package:get/get.dart';

import '../data/api/api_checker.dart';
import '../data/models/response/hotel_response.dart';
import '../data/repositories/hotel_repository.dart';

class HotelController extends GetxController implements GetxService {
  HotelController({required this.hotelRepo});

  final HotelRepository hotelRepo;

  HotelResponse? _hotel;
  List<HotelResponse>? _hotels;
  List<HotelResponse>? _searchHotels;

  HotelResponse? get hotel => _hotel;
  List<HotelResponse>? get hotels => _hotels;
  List<HotelResponse>? get searchHotels => _searchHotels;

  Future<int> getAllHotels() async {
    Response response = await hotelRepo.getAllHotel();

    if (response.statusCode == 200) {
      _hotels ??= [];

      for (var hotel in response.body["data"]) {
        _hotels!.add(HotelResponse.fromJson(hotel));
      }
      update();
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }

    return response.statusCode!;
  }

  Future<int> getHotelMySelf() async {
    Response response = await hotelRepo.getHotelMySelf();

    if (response.statusCode == 200) {
      _hotel = HotelResponse.fromJson(response.body["data"]);
      update();
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }

    return response.statusCode!;
  }

  Future<int> getAllHotelsByName(String nameHotel) async {
    Response response = await hotelRepo.getAllHotelByName(nameHotel);

    if (response.statusCode == 200) {
      _searchHotels ??= [];

      for (var hotel in response.body["data"]) {
        _searchHotels!.add(HotelResponse.fromJson(hotel));
      }
      update();
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }

    return response.statusCode!;
  }

  void clearData() {
    _hotel = null;
    _hotels = null;
  }

  void clearDataSearch() {
    _searchHotels = null;
  }
}
