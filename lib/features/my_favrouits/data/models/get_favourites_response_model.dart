  class GetFavoritesResponseModel {
  GetFavoritesResponseModel({
  required this.msg,
  required this.data,
  });
  late final String msg;
  late final List<Data> data;

  GetFavoritesResponseModel.fromJson(Map<String, dynamic> json){
  msg = json['msg'];
  data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['msg'] = msg;
  _data['data'] = data.map((e)=>e.toJson()).toList();
  return _data;
  }
  }

  class Data {
  Data({
  required this.id,
  required this.customer,
  required this.product,
  });
  late final String id;
  late final String customer;
  late final Product product;

  Data.fromJson(Map<String, dynamic> json){
  id = json['_id'];
  customer = json['customer'];
  product = Product.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['_id'] = id;
  _data['customer'] = customer;
  _data['product'] = product.toJson();
  return _data;
  }
  }

  class Product {
  Product({
  required this.id,
  required this.name,
  required this.thumbnail,
  required this.actualPrice,
  required this.isFavourite,
  });
  late final String id;
  late final String name;
  late final String thumbnail;
  late final String actualPrice;
  late final String isFavourite;

  Product.fromJson(Map<String, dynamic> json){
  id = json['_id'];
  name = json['name'];
  thumbnail = json['thumbnail'];
  actualPrice = json['actualPrice'];
  isFavourite = json['isFavourite'];
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['_id'] = id;
  _data['name'] = name;
  _data['thumbnail'] = thumbnail;
  _data['actualPrice'] = actualPrice;
  _data['isFavourite'] = isFavourite;
  return _data;
  }
  }