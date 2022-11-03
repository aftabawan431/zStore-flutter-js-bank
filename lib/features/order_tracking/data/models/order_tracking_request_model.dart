class OrderTrackingRequestModel {
  OrderTrackingRequestModel({
    required this.Name,
  });
  late final String Name;

  OrderTrackingRequestModel.fromJson(Map<String, dynamic> json){
    Name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Name'] = Name;
    return _data;
  }
}