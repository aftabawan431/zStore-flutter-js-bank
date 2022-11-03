







  class GetOrderHistoryDetailsResponseModel {
  GetOrderHistoryDetailsResponseModel({
  required this.msg,
  required this.data,
  });
  late final String msg;
  late final Data data;

  GetOrderHistoryDetailsResponseModel.fromJson(Map<String, dynamic> json){
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
  required this.product,
  required this.status,
  required this.orderId,
  required this.trackingId,
  required this.placedOn,
  required this.productThumbnail,
  });
  late final String id;
  late final List<Product> product;
  late final String status;
  late final String orderId;
  late final String trackingId;
  late final String placedOn;
  late final String productThumbnail;

  Data.fromJson(Map<String, dynamic> json){
  id = json['_id'];
  product = List.from(json['product']).map((e)=>Product.fromJson(e)).toList();
  status = json['status'];
  orderId = json['orderId'];
  trackingId = json['trackingId'];
  placedOn = json['placedOn'];
  productThumbnail = json['productThumbnail'];
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['_id'] = id;
  _data['product'] = product.map((e)=>e.toJson()).toList();
  _data['status'] = status;
  _data['orderId'] = orderId;
  _data['trackingId'] = trackingId;
  _data['placedOn'] = placedOn;
  _data['productThumbnail'] = productThumbnail;
  return _data;
  }
  }

  class Product {
  Product({
  required this.quantity,
  required this.price,
  required this.productName,
  required this.productCategory,
  required this.productQuantity,
  required this.productPrice,
  });
  late final int quantity;
  late final int price;
  late final String productName;
  late final String productCategory;
  late final int productQuantity;
  late final int productPrice;

  Product.fromJson(Map<String, dynamic> json){
  quantity = json['quantity'];
  price = json['price'];
  productName = json['productName'];
  productCategory = json['productCategory'];
  productQuantity = json['productQuantity'];
  productPrice = json['productPrice'];
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['quantity'] = quantity;
  _data['price'] = price;
  _data['productName'] = productName;
  _data['productCategory'] = productCategory;
  _data['productQuantity'] = productQuantity;
  _data['productPrice'] = productPrice;
  return _data;
  }
  }