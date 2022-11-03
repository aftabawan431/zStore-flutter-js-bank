

class GetAllReviewsResponseModel {
  GetAllReviewsResponseModel({
    required this.msg,
    required this.ID,
    required this.data,
  });
  late final String msg;
  late final String ID;
  late final List<Data> data;

  GetAllReviewsResponseModel.fromJson(Map<String, dynamic> json){
    msg = json['msg'];
    ID = json['ID'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['msg'] = msg;
    _data['ID'] = ID;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.rating,
    required this.image,
    required this.productName,
    required this.discountedPrice,
    required this.customerName,
  });
  late final String id;
  late final int rating;
  late final String image;
  late final String productName;
  late final int discountedPrice;
  late final String customerName;

  Data.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    rating = json['rating'];
    image = json['image'];
    productName = json['productName'];
    discountedPrice = json['discountedPrice'];
    customerName = json['customerName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['rating'] = rating;
    _data['image'] = image;
    _data['productName'] = productName;
    _data['discountedPrice'] = discountedPrice;
    _data['customerName'] = customerName;
    return _data;
  }
}