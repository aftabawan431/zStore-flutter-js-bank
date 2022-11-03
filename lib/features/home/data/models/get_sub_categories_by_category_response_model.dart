class GetSubCategoriesByCategoryIdResponseModel {
  GetSubCategoriesByCategoryIdResponseModel({
    required this.msg,
    required this.data,
  });
  late final String msg;
  late final Data data;

  GetSubCategoriesByCategoryIdResponseModel.fromJson(Map<String, dynamic> json){
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
    required this.category,
    required this.subcategories,
  });
  late final Category category;
  late final List<Subcategories> subcategories;

  Data.fromJson(Map<String, dynamic> json){
    category = Category.fromJson(json['category']);
    subcategories = List.from(json['subcategories']).map((e)=>Subcategories.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['category'] = category.toJson();
    _data['subcategories'] = subcategories.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });
  late final String id;
  late final String name;
  late final String icon;
  late final String description;

  Category.fromJson(Map<String, dynamic> json){
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

class Subcategories {
  Subcategories({
    required this.id,
    required this.name,
  });
  late final String id;
  late final String name;

  Subcategories.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['name'] = name;
    return _data;
  }
}