import 'package:equatable/equatable.dart';

class LogoutRequestModel extends Equatable {
  const LogoutRequestModel({
    required this.authorization,
  });

  final String authorization;

  factory LogoutRequestModel.fromJson(Map<String, dynamic> json) {
    return LogoutRequestModel(
      authorization: json['Authorization'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> _data = {};
    _data['Authorization'] = authorization;

    return _data;
  }

  @override
  List<Object?> get props => [
        authorization,
      ];
}
