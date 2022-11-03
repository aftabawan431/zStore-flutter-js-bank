

class ProfileImageResponseModel {
  ProfileImageResponseModel({
    required this.msg,
  });
  late final String msg;

  ProfileImageResponseModel.fromJson(Map<String, dynamic> json){
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['msg'] = msg;
    return _data;
  }
}