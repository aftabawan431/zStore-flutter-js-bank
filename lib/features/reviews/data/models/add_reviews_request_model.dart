  class AddReviewRequestModel {
  AddReviewRequestModel({
  required this.productId,
  required this.customerId,
  required this.rating,
  required this.comment,
  required this.images,
  });
  late final String productId;
  late final String customerId;
  late final int rating;
  late final String comment;
  late final List<String> images;

  AddReviewRequestModel.fromJson(Map<String, dynamic> json){
  productId = json['productId'];
  customerId = json['customerId'];
  rating = json['rating'];
  comment = json['comment'];
  images = List.castFrom<dynamic, String>(json['images']);
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['productId'] = productId;
  _data['customerId'] = customerId;
  _data['rating'] = rating;
  _data['comment'] = comment;
  _data['images'] = images;
  return _data;
  }
  }