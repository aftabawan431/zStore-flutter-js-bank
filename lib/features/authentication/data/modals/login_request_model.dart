import 'package:equatable/equatable.dart';

class LoginRequestModel extends Equatable {
  const LoginRequestModel({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {};
    _data['email'] = email;
    _data['password'] = password;

    return _data;
  }

  @override
  List<Object?> get props => [email, password];
}
