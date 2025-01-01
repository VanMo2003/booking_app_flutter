import 'package:booking_app_demo/data/models/response/statistical_response.dart';
import 'package:booking_app_demo/data/repositories/statistical_repository.dart';
import 'package:get/get.dart';

import '../data/api/api_checker.dart';

class StatisticalController extends GetxController implements GetxService{
  StatisticalController({required this.statisticalRepo});

  StatisticalRepository statisticalRepo;

  List<StatisticalResponse>? _statistical;
  List<StatisticalResponse>? get statistical => _statistical;


  Future<int> getStatisticalByHotel() async {
    Response response = await statisticalRepo.getStatisticalByHotel();

    if (response.statusCode == 200) {
      _statistical ??= [];

      for (var hotel in response.body["data"]) {
        _statistical!.add(StatisticalResponse.fromJson(hotel));
      }
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }

    update();

    return response.statusCode!;
  }

  void clearData(){
    _statistical = null;
  }
}