import 'package:get/get.dart';

import '../data/api/api_checker.dart';
import '../data/models/body/service.dart';
import '../data/models/response/service_response.dart';
import '../data/repositories/service_repository.dart';

class ServiceController extends GetxController implements GetxService {
  ServiceController({required this.serviceRepo});

  ServiceRepository serviceRepo;

  List<ServiceResponse>? _services;

  List<ServiceResponse>? get service => _services;

  Future<int> getAllServiceByHotel() async {
    Response response = await serviceRepo.getAllServiceByHotel();

    if (response.statusCode == 200) {
      _services ??= [];

      for (var hotel in response.body["data"]) {
        _services!.add(ServiceResponse.fromJson(hotel));
      }
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }

    return response.statusCode!;
  }

  Future<int> creatService(Service service) async {
    Response response = await serviceRepo.creatService(service);

    if (response.statusCode == 200) {
      _services!.add(ServiceResponse.fromJson(response.body["data"]));
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }
    update();

    return response.statusCode!;
  }

  void clearData() {
    _services = null;
  }
}
