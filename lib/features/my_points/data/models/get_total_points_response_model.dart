
    class GetTotalPointsResponseModel {
      GetTotalPointsResponseModel({
    required this.msg,
    required this.data,
    });
    late final String msg;
    late final Data data;

      GetTotalPointsResponseModel.fromJson(Map<String, dynamic> json){
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
    required this.customerId,
    required this.totalPoints,
    });
    late final String customerId;
    late final int totalPoints;

    Data.fromJson(Map<String, dynamic> json){
    customerId = json['customerId'];
    totalPoints = json['totalPoints'];
    }

    Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['customerId'] = customerId;
    _data['totalPoints'] = totalPoints;
    return _data;
    }
    }