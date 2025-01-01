import 'package:get/get.dart';

import '../../utils/app_constant.dart';
import '../api/api_client.dart';
import '../models/body/service.dart';

class ServiceRepository extends GetxService {
  ServiceRepository({required this.apiClient});
  ApiClient apiClient;

  Future<Response> getAllServiceByHotel() {
    return apiClient.getData(AppConstant.ENDPOINT_GET_ALL_SERVICE_BY_HOTEL);
  }

  Future<Response> creatService(Service service) {
    return apiClient.postData(
      AppConstant.ENDPOINT_CREATE_SERVICE,
      service,
    );
  }
}
