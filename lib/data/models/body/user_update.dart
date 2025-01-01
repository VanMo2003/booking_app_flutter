class UserUpdate {
  String? fullName;
  String? phone;
  String? gender;
  String? dateOfBirth;
  String? birthPlace;
  String? address;

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

  UserUpdate(
      {this.fullName,
      this.phone,
      this.gender,
      this.dateOfBirth,
      this.birthPlace,
      this.address});

  UserUpdate.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    phone = json['phone'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    birthPlace = json['birthPlace'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['phone'] = phone;
    data['gender'] = gender;
    data['dateOfBirth'] = dateOfBirth;
    data['birthPlace'] = birthPlace;
    data['address'] = address;
    return data;
  }
}
