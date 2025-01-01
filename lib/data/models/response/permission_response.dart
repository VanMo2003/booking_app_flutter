class PermissionResponse {
  String? name;
  String? description;

  PermissionResponse({this.name, this.description});

  PermissionResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}
