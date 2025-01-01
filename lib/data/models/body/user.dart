class User {
  String? username;
  String? password;
  String? fullName;
  String? phone;
  String? gender;
  String? dateOfBirth;
  String? birthPlace;
  String? address;
  String? role;

  User({
    this.username,
    this.password,
    this.fullName,
    this.phone,
    this.gender,
    this.dateOfBirth,
    this.birthPlace,
    this.address,
    this.role,
  });

  set setUsername(String username) {
    this.username = username;
  }

  set setPassword(String password) {
    this.password = password;
  }

  set setFullName(String fullName) {
    this.fullName = fullName;
  }

  set setPhone(String phone) {
    this.phone = phone;
  }

  set setGender(String gender) {
    this.gender = gender;
  }

  set setDateOfBirth(String dateOfBirth) {
    this.dateOfBirth = dateOfBirth;
  }

  set setBirthPlace(String birthPlace) {
    this.birthPlace = birthPlace;
  }

  set setAddress(String address) {
    this.address = address;
  }

  set setRole(String role) {
    this.role = role;
  }

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    fullName = json['fullName'];
    phone = json['phone'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    birthPlace = json['birthPlace'];
    address = json['address'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['fullName'] = fullName;
    data['phone'] = phone;
    data['gender'] = gender;
    data['dateOfBirth'] = dateOfBirth;
    data['birthPlace'] = birthPlace;
    data['address'] = address;
    data['role'] = role;
    return data;
  }

  User copyWith({
    String? username,
    String? password,
    String? fullName,
    String? phone,
    String? gender,
    String? dateOfBirth,
    String? birthPlace,
    String? address,
    List<String>? roles,
  }) {
    return User(
      username: username ?? this.username,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      birthPlace: birthPlace ?? this.birthPlace,
      address: address ?? this.address,
    );
  }
}
