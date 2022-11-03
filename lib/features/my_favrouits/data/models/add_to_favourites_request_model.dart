class AddToFavouriteRequestModel {
  AddToFavouriteRequestModel({
    required this.customerId,
    required this.productId,
  });
  late final String customerId;
  late final String productId;

  AddToFavouriteRequestModel.fromJson(Map<String, dynamic> json){
    customerId = json['customerId'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['customerId'] = customerId;
    _data['productId'] = productId;
    return _data;
  }
}