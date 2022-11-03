

class GetCategoriesAndProductsResponseModel {
  GetCategoriesAndProductsResponseModel({
    required this.msg,
    required this.data,
  });
  late final String msg;
  late final Data data;

  GetCategoriesAndProductsResponseModel.fromJson(Map<String, dynamic> json){
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
    required this.categories,
    required this.subcategories,
    required this.products,
  });
  late final List<Categories> categories;
  late final List<Subcategories> subcategories;
  late final List<Products> products;

  Data.fromJson(Map<String, dynamic> json){
    categories = List.from(json['categories']).map((e)=>Categories.fromJson(e)).toList();
    subcategories = List.from(json['subcategories']).map((e)=>Subcategories.fromJson(e)).toList();
    products = List.from(json['products']).map((e)=>Products.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['categories'] = categories.map((e)=>e.toJson()).toList();
    _data['subcategories'] = subcategories.map((e)=>e.toJson()).toList();
    _data['products'] = products.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Categories {
  Categories({
    required this.id,
    required this.name,
    required this.icon,
  });
  late final String id;
  late final String name;
  late final String icon;

  Categories.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['name'] = name;
    _data['icon'] = icon;
    return _data;
  }
}

class Subcategories {
  Subcategories({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });
  late final String id;
  late final String name;
  late final String icon;
  late final String description;

  Subcategories.fromJson(Map<String, dynamic> json){
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
    required this.thumbnail,
  });
  late final String id;
  late final String thumbnail;

  Products.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['thumbnail'] = thumbnail;
    return _data;
  }
}