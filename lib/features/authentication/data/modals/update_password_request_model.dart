
class UpdatePasswordRequestModel {
  UpdatePasswordRequestModel({
    required this.email,
    required this.password,
    required this.reEnterPassword,
  });
  late final String email;
  late final String password;
  late final String reEnterPassword;

  UpdatePasswordRequestModel.fromJson(Map<String, dynamic> json){
    email = json['email'];
    password = json['password'];
    reEnterPassword = json['reEnterPassword'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;
    _data['reEnterPassword'] = reEnterPassword;
    return _data;
  }
}