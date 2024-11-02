import 'package:get/get.dart';

import '../data/api/api_checker.dart';
import '../data/models/response/hotel_response.dart';
import '../data/repositories/hotel_repository.dart';

class HotelController extends GetxController implements GetxService {
  HotelController({required this.hotelRepo});

  final HotelRepository hotelRepo;

  List<HotelResponse>? _hotels;

  List<HotelResponse>? get hotels => _hotels;

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

  void clearData() {
    _hotels = null;
  }
}
