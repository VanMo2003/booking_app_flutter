import 'dart:developer';

import 'package:get/get.dart';

import '../../utils/app_constant.dart';
import '../api/api_client.dart';

class StatisticalRepository extends GetxService {
  StatisticalRepository({required this.apiClient});
  ApiClient apiClient;

  // Future<Response> updateMonthlyStatistic() {
  //   return apiClient.postData(AppConstant.ENDPOINT_GET_ALL_SERVICE_BY_HOTEL);
  // }

  Future<Response> getStatisticalByHotel() {
    return apiClient.getData(AppConstant.ENDPOINT_GET_STATISTICAL_BY_HOTEL);
  }

}