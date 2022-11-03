import 'package:equatable/equatable.dart';

class ErrorResponseModel extends Equatable {
  const ErrorResponseModel({

    required this.statusMessage,
  });


  final String? statusMessage;

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return ErrorResponseModel(
      statusMessage: json['msg'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['msg'] = statusMessage;

    return _data;
  }

  @override
  List<Object?> get props => [
        statusMessage,
      ];
}

