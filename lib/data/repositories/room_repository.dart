import 'package:get/get.dart';

import '../../utils/app_constant.dart';
import '../api/api_client.dart';
import '../models/body/room.dart';

class RoomRepository extends GetxService {
  RoomRepository({required this.apiClient});
  ApiClient apiClient;

  Future<Response> getAllRoomByHotel() {
    return apiClient.getData(AppConstant.ENDPOINT_GET_ALL_ROOM_BY_HOTEL);
  }

  Future<Response> creatRoom(Room room) {
    return apiClient.postData(
      AppConstant.ENDPOINT_CREATE_ROOM,
      room,
    );
  }
}
