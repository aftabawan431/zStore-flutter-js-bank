


class UpdateProfileDetailsRequestModel {
  UpdateProfileDetailsRequestModel({
    required this.customerID,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contact,
    required this.address,
    required this.gender,
  });
  late final String customerID;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String contact;
  late final String address;
  late final String gender;

  UpdateProfileDetailsRequestModel.fromJson(Map<String, dynamic> json){
    customerID = json['customerID'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    contact = json['contact'];
    address = json['address'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['customerID'] = customerID;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['email'] = email;
    _data['contact'] = contact;
    _data['address'] = address;
    _data['gender'] = gender;
    return _data;
  }
}