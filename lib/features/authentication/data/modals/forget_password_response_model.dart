import 'package:equatable/equatable.dart';

class ForgetPasswordResponseModel extends Equatable {
  const ForgetPasswordResponseModel({
    required this.message,
  });

  final String message;

  factory ForgetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordResponseModel(
      message: json['msg'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['msg'] = message;

    return data;
  }

  @override
  List<Object?> get props => [
        message,
      ];
}
