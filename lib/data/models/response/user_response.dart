import 'role_response.dart';

class UserResponse {
  String? id;
  String? username;
  String? fullName;
  String? phone;
  String? gender;
  String? dateOfBirth;
  String? birthPlace;
  String? address;
  RoleResponse? role;
  bool? active;
  String? onCreate;
  String? onUpdate;

  UserResponse(
      {this.id,
      this.username,
      this.fullName,
      this.phone,
      this.gender,
      this.dateOfBirth,
      this.birthPlace,
      this.address,
      this.role,
      this.active,
      this.onCreate,
      this.onUpdate});

  UserResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['fullName'];
    phone = json['phone'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    birthPlace = json['birthPlace'];
    address = json['address'];
    role = json['role'] != null ? RoleResponse.fromJson(json['role']) : null;
    active = json['active'];
    onCreate = json['onCreate'];
    onUpdate = json['onUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['fullName'] = fullName;
    data['phone'] = phone;
    data['gender'] = gender;
    data['dateOfBirth'] = dateOfBirth;
    data['birthPlace'] = birthPlace;
    data['address'] = address;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    data['active'] = active;
    data['onCreate'] = onCreate;
    data['onUpdate'] = onUpdate;
    return data;
  }
}
