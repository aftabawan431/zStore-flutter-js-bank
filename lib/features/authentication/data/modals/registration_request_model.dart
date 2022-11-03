


class RegistrationRequestModel {
  RegistrationRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contact,
    required this.reEnterPassword,
    required this.password,
    required this.address,
    required this.gender,
  });
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String contact;
  late final String reEnterPassword;
  late final String password;
  late final String address;
  late final String gender;

  RegistrationRequestModel.fromJson(Map<String, dynamic> json){
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    contact = json['contact'];
    reEnterPassword = json['reEnterPassword'];
    password = json['password'];
    address = json['address'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['email'] = email;
    _data['contact'] = contact;
    _data['reEnterPassword'] = reEnterPassword;
    _data['password'] = password;
    _data['address'] = address;
    _data['gender'] = gender;
    return _data;
  }
}