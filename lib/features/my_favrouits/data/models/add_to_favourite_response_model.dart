
class AddToFavouriteResponseModel {
  AddToFavouriteResponseModel({
    required this.msg,
    required this.data,
  });
  late final String msg;
  late final String data;

  AddToFavouriteResponseModel.fromJson(Map<String, dynamic> json){
    msg = json['msg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['msg'] = msg;
    _data['data'] = data;
    return _data;
  }
}