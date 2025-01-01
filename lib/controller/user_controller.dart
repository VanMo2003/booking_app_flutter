import 'package:get/get.dart';

import '../data/api/api_checker.dart';
import '../data/models/body/user.dart';
import '../data/models/response/api_response.dart';
import '../data/models/response/user_response.dart';
import '../data/repositories/user_repository.dart';

enum Role { admin, hotelier, user, un_known }

class UserController extends GetxController implements GetxService {
  UserController({required this.userRepo});

  final UserRepository userRepo;

  Role _role = Role.un_known;
  UserResponse? _user;
  User? _userRequest;

  Role? get role => _role;
  UserResponse? get user => _user;
  User? get userRequest => _userRequest;

  Future<int> createUser(User user) async {
    Response response = await userRepo.createUser(user);

    ApiResponse apiResponse = ApiResponse.fromJson(response.body);

    if (response.statusCode == 200) {
      // _user = UserResponse.fromJson(apiResponse.data);

      // checkRole();
    } else {
      ApiChecker.apiChecker(apiResponse.code!);
    }
    return response.statusCode!;
  }

  Future<int> getMyInfo() async {
    Response response = await userRepo.getMyInfo();

    if (response.statusCode == 200) {
      _user = UserResponse.fromJson(response.body["data"]);

      checkRole();
    } else {
      ApiChecker.apiChecker(response.statusCode!);
    }

    update();

    return 0;
  }

  Future<bool> checkExistUser(String username) async {
    Response response = await userRepo.checkExistUser(username);

    ApiResponse apiResponse = ApiResponse.fromJson(response.body);

    return apiResponse.data;
  }

  void setUserRequest(String username, String password) {
    _userRequest = User(username: username, password: password);
  }

  void checkRole() {
    if (_user != null) {
      String? nameRole = _user!.role!.name;

      switch (nameRole) {
        case "ADMIN":
          _role = Role.admin;
        case "HOTELIER":
          _role = Role.hotelier;
        case "USER":
          _role = Role.user;
        default:
          _role = Role.un_known;
      }
    }
  }

  void clearData() {
    _role = Role.un_known;
    _user = null;
  }
}
