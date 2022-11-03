class ValidateOtpResponseModel {
  ValidateOtpResponseModel({
    required this.message,
  });
  late final String message;

  ValidateOtpResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['msg'] = message;
    return _data;
  }
}
