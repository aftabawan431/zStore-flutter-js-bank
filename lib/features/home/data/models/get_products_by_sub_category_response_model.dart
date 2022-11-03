

  class GetProductsBySubCategoriesResponseModel {
  GetProductsBySubCategoriesResponseModel({
  required this.msg,
  required this.data,
  });
  late final String msg;
  late final Data data;

  GetProductsBySubCategoriesResponseModel.fromJson(Map<String, dynamic> json){
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
  required this.subcategory,
  required this.products,
  });
  late final Subcategory subcategory;
  late final List<Products> products;

  Data.fromJson(Map<String, dynamic> json){
  subcategory = Subcategory.fromJson(json['subcategory']);
  products = List.from(json['products']).map((e)=>Products.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['subcategory'] = subcategory.toJson();
  _data['products'] = products.map((e)=>e.toJson()).toList();
  return _data;
  }
  }

  class Subcategory {
  Subcategory({
  required this.id,
  required this.name,
  required this.icon,
  required this.description,
  });
  late final String id;
  late final String name;
  late final String icon;
  late final String description;

  Subcategory.fromJson(Map<String, dynamic> json){
  id = json['_id'];
  name = json['name'];
  icon = json['icon'];
  description = json['description'];
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['_id'] = id;
  _data['name'] = name;
  _data['icon'] = icon;
  _data['description'] = description;
  return _data;
  }
  }

  class Products {
  Products({
  required this.id,
  required this.name,
  required this.title,
  required this.thumbnail,
  required this.price,
  });
  late final String id;
  late final String name;
  late final String title;
  late final String thumbnail;
  late final int price;

  Products.fromJson(Map<String, dynamic> json){
  id = json['_id'];
  name = json['name'];
  title = json['title'];
  thumbnail = json['thumbnail'];
  price = json['price'];
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['_id'] = id;
  _data['name'] = name;
  _data['title'] = title;
  _data['thumbnail'] = thumbnail;
  _data['price'] = price;
  return _data;
  }
  }