




class GetOrderHistoryResponseModel {
  GetOrderHistoryResponseModel({
    required this.msg,
    required this.data,
  });
  late final String msg;
  late final List<Data> data;

  GetOrderHistoryResponseModel.fromJson(Map<String, dynamic> json){
    msg = json['msg'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['msg'] = msg;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.status,
    required this.orderId,
    required this.placedOn,
    required this.thumbnail,
  });
  late final String id;
  late final String status;
  late final String orderId;
  late final String placedOn;
  late final String thumbnail;

  Data.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    status = json['status'];
    orderId = json['orderId'];
    placedOn = json['placedOn'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['status'] = status;
    _data['orderId'] = orderId;
    _data['placedOn'] = placedOn;
    _data['thumbnail'] = thumbnail;
    return _data;
  }
}