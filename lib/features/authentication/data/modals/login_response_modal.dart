
class LoginResponseModel {
  LoginResponseModel({
    required this.msg,
    required this.data,
  });
  late final String msg;
  late final Data data;

  LoginResponseModel.fromJson(Map<String, dynamic> json){
    msg = json['msg'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['msg'] = msg;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contact,
    required this.address,
    required this.gender,
    required this.image,
  });
  late final String userId;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String contact;
  late final String address;
  late final String gender;
  late final String image;

  Data.fromJson(Map<String, dynamic> json){
    userId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    contact = json['contact'];
    address = json['address'];
    gender = json['gender'];
    image = json['image']??'';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = userId;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['email'] = email;
    _data['contact'] = contact;
    _data['address'] = address;
    _data['gender'] = gender;
    _data['image'] = image??'';
    return _data;
  }
}

