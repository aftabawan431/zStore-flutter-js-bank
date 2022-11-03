import 'package:equatable/equatable.dart';

class LogoutResponseModel extends Equatable {
  const LogoutResponseModel({
    required this.success,
    required this.message,
  });

  final bool success;
  final String message;

  factory LogoutResponseModel.fromJson(Map<String, dynamic> json) {
    return LogoutResponseModel(
      success: json['success'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {};
    _data['success'] = success;
    _data['message'] = message;

    return _data;
  }

  @override
  List<Object?> get props => [
        success,
        message,
      ];
}
