import 'package:equatable/equatable.dart';

class ValidateOtpRequestModel extends Equatable {
  const ValidateOtpRequestModel({required this.otpCode, required this.email});

  final String otpCode;
  final String email;
  factory ValidateOtpRequestModel.fromJson(Map<String, dynamic> json) {
    return ValidateOtpRequestModel(
      otpCode: json['otp'],
      email: json['email'],
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {};
    _data['otp'] = otpCode;
    _data['email'] = email;
    return _data;
  }

  @override
  List<Object?> get props => [otpCode, email];
}
