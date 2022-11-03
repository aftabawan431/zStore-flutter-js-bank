

class SeeReviewDetailsResponseModel {
  SeeReviewDetailsResponseModel({
    required this.msg,
    required this.data,
  });
  late final String msg;
  late final Data data;

  SeeReviewDetailsResponseModel.fromJson(Map<String, dynamic> json){
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
    required this.id,
    required this.rating,
    required this.comment,
    required this.images,
    required this.customerName,
    required this.productName,
  });
  late final String id;
  late final int rating;
  late final String comment;
  late final List<String> images;
  late final String customerName;
  late final String productName;

  Data.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    rating = json['rating'];
    comment = json['comment'];
    images = List.castFrom<dynamic, String>(json['images']);
    customerName = json['customerName'];
    productName = json['productName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['rating'] = rating;
    _data['comment'] = comment;
    _data['images'] = images;
    _data['customerName'] = customerName;
    _data['productName'] = productName;
    return _data;
  }
}