

  class GetProductByIdResponseModel {
  GetProductByIdResponseModel({
  required this.msg,
  required this.data,
  });
  late final String msg;
  late final Data data;

  GetProductByIdResponseModel.fromJson(Map<String, dynamic> json){
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
  required this.category,
  required this.subcategory,
  required this.name,
  required this.title,
  required this.description,
  required this.variant,
  required this.thumbnail,
  required this.images,
  required this.vendor,
  required this.isActive,
  required this.isFeatured,
  required this.isSale,
  required this.isDeal,
  required this.inStock,
  required this.sequence,
  required this.ratingCount,
  required this.ratingNumber,
  required this.isFavourite,
  required this.metaData,
  required this.metaDescription,
  });
  late final String id;
  late final Category category;
  late final Subcategory subcategory;
  late final String name;
  late final String title;
  late final String description;
  late final List<Variant> variant;
  late final String thumbnail;
  late final List<String> images;
  late final String vendor;
  late final bool isActive;
  late final bool isFeatured;
  late final bool isSale;
  late final bool isDeal;
  late final bool inStock;
  late final int sequence;
  late final int ratingCount;
  late final int ratingNumber;
  late final bool isFavourite;
  late final List<String> metaData;
  late final List<String> metaDescription;

  Data.fromJson(Map<String, dynamic> json){
  id = json['_id'];
  category = Category.fromJson(json['category']);
  subcategory = Subcategory.fromJson(json['subcategory']);
  name = json['name'];
  title = json['title'];
  description = json['description'];
  variant = List.from(json['variant']).map((e)=>Variant.fromJson(e)).toList();
  thumbnail = json['thumbnail'];
  images = List.castFrom<dynamic, String>(json['images']);
  vendor = json['vendor'];
  isActive = json['isActive'];
  isFeatured = json['isFeatured'];
  isSale = json['isSale'];
  isDeal = json['isDeal'];
  inStock = json['inStock'];
  sequence = json['sequence'];
  ratingCount = json['ratingCount'];
  ratingNumber = json['ratingNumber'];
  isFavourite = json['isFavourite'];
  metaData = List.castFrom<dynamic, String>(json['metaData']);
  metaDescription = List.castFrom<dynamic, String>(json['metaDescription']);
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['_id'] = id;
  _data['category'] = category.toJson();
  _data['subcategory'] = subcategory.toJson();
  _data['name'] = name;
  _data['title'] = title;
  _data['description'] = description;
  _data['variant'] = variant.map((e)=>e.toJson()).toList();
  _data['thumbnail'] = thumbnail;
  _data['images'] = images;
  _data['vendor'] = vendor;
  _data['isActive'] = isActive;
  _data['isFeatured'] = isFeatured;
  _data['isSale'] = isSale;
  _data['isDeal'] = isDeal;
  _data['inStock'] = inStock;
  _data['sequence'] = sequence;
  _data['ratingCount'] = ratingCount;
  _data['ratingNumber'] = ratingNumber;
  _data['isFavourite'] = isFavourite;
  _data['metaData'] = metaData;
  _data['metaDescription'] = metaDescription;
  return _data;
  }
  }

  class Category {
  Category({
  required this.id,
  required this.name,
  });
  late final String id;
  late final String name;

  Category.fromJson(Map<String, dynamic> json){
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

  class Subcategory {
  Subcategory({
  required this.id,
  required this.name,
  });
  late final String id;
  late final String name;

  Subcategory.fromJson(Map<String, dynamic> json){
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

  class Variant {
  Variant({
  required this.colorName,
  required this.colorHex,
  required this.actualPrice,
  required this.discountedPrice,
  required this.quantity,
  required this.sku,
  required this.size,
  required this.id,
  });
  late final String colorName;
  late final String colorHex;
  late final int actualPrice;
  late final int discountedPrice;
  late final int quantity;
  late final String sku;
  late final List<String> size;
  late final String id;

  Variant.fromJson(Map<String, dynamic> json){
  colorName = json['colorName'];
  colorHex = json['colorHex'];
  actualPrice = json['actualPrice'];
  discountedPrice = json['discountedPrice'];
  quantity = json['quantity'];
  sku = json['sku'];
  size = List.castFrom<dynamic, String>(json['size']);
  id = json['_id'];
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['colorName'] = colorName;
  _data['colorHex'] = colorHex;
  _data['actualPrice'] = actualPrice;
  _data['discountedPrice'] = discountedPrice;
  _data['quantity'] = quantity;
  _data['sku'] = sku;
  _data['size'] = size;
  _data['_id'] = id;
  return _data;
  }
  }