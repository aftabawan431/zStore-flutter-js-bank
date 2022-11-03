




class ClearOrderHistoryResponseModel {
  ClearOrderHistoryResponseModel({
    required this.msg,
  });
  late final String msg;

  ClearOrderHistoryResponseModel.fromJson(Map<String, dynamic> json){
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['msg'] = msg;
    return _data;
  }
}

