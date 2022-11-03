class DeleteFavouriteResponseModel {
  DeleteFavouriteResponseModel({
    required this.msg,
    required this.data,
  });
  late final String msg;
  late final Data data;

  DeleteFavouriteResponseModel.fromJson(Map<String, dynamic> json){
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
    required this.acknowledged,
    required this.deletedCount,
  });
  late final bool acknowledged;
  late final int deletedCount;

  Data.fromJson(Map<String, dynamic> json){
    acknowledged = json['acknowledged'];
    deletedCount = json['deletedCount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['acknowledged'] = acknowledged;
    _data['deletedCount'] = deletedCount;
    return _data;
  }
}