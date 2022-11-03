import 'package:equatable/equatable.dart';

class GenerateOtpRequestModel extends Equatable {
  const GenerateOtpRequestModel({
    required this.email,
  });

  final String email;

  factory GenerateOtpRequestModel.fromJson(Map<String, dynamic> json) {
    return GenerateOtpRequestModel(
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {};
    _data['email'] = email;

    return _data;
  }

  @override
  List<Object?> get props => [
        email,
      ];
}
