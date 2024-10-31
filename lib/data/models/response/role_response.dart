import 'permission_response.dart';

class RoleResponse {
  String? name;
  String? description;
  List<PermissionResponse>? permissions;

  RoleResponse({this.name, this.description, this.permissions});

  RoleResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    if (json['permissions'] != null) {
      permissions = <PermissionResponse>[];
      json['permissions'].forEach((v) {
        permissions!.add(PermissionResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    if (permissions != null) {
      data['permissions'] = permissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
