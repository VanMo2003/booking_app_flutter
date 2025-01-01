import 'package:get/get.dart';

import '../data/api/api_checker.dart';
import '../data/models/body/room.dart';
import '../data/models/response/room_response.dart';
import '../data/repositories/room_repository.dart';

class RoomController extends GetxController implements GetxService {
  RoomController({required this.roomRepo});

  RoomRepository roomRepo;

  List<RoomResponse>? _rooms;

  List<RoomResponse>? get rooms => _rooms;

  Future<int> getAllRoomByHotel() async {
    Response response = await roomRepo.getAllRoomByHotel();

    if (response.statusCode == 200) {
      _rooms ??= [];

      for (var hotel in response.body["data"]) {
        _rooms!.add(RoomResponse.fromJson(hotel));
      }
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }

    return response.statusCode!;
  }

  Future<int> creatRoom(Room room) async {
    Response response = await roomRepo.creatRoom(room);

    if (response.statusCode == 200) {
      _rooms!.add(RoomResponse.fromJson(response.body["data"]));
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }
    update();

    return response.statusCode!;
  }

  void clearData() {
    _rooms = null;
  }
}
