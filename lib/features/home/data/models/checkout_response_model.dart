import 'package:equatable/equatable.dart';



class CheckoutResponseModel {
  CheckoutResponseModel({
    required this.msg,
    required this.data,
  });
  late final String msg;
  late final Data data;

  CheckoutResponseModel.fromJson(Map<String, dynamic> json){
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
    required this.trackingId,
  });
  late final String trackingId;

  Data.fromJson(Map<String, dynamic> json){
    trackingId = json['trackingId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['trackingId'] = trackingId;
    return _data;
  }
}