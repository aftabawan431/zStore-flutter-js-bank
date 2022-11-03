

import 'package:equatable/equatable.dart';



  class CheckoutRequestModel {
  CheckoutRequestModel({
  required this.customer,
  required this.product,
  required this.address,
  required this.contact,
  required this.paymentMode,
  required this.totalBill,
  required this.channel,
  });
  late final String customer;
  late final List<Product> product;
  late final String address;
  late final String contact;
  late final String paymentMode;
  late final String totalBill;
  late final String channel;

  CheckoutRequestModel.fromJson(Map<String, dynamic> json){
  customer = json['customer'];
  product = List.from(json['product']).map((e)=>Product.fromJson(e)).toList();
  address = json['address'];
  contact = json['contact'];
  paymentMode = json['paymentMode'];
  totalBill = json['totalBill'];
  channel = json['channel'];
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['customer'] = customer;
  _data['product'] = product.map((e)=>e.toJson()).toList();
  _data['address'] = address;
  _data['contact'] = contact;
  _data['paymentMode'] = paymentMode;
  _data['totalBill'] = totalBill;
  _data['channel'] = channel;
  return _data;
  }
  }

  class Product {
  Product({
  required this.productId,
  required this.quantity,
  required this.price,
  required this.sku,
  required this.size,
  });
  late final String productId;
  late final int quantity;
  late final int price;
  late final String sku;
  late final String size;

  Product.fromJson(Map<String, dynamic> json){
  productId = json['productId'];
  quantity = json['quantity'];
  price = json['price'];
  sku = json['sku'];
  size = json['size'];
  }

  Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['productId'] = productId;
  _data['quantity'] = quantity;
  _data['price'] = price;
  _data['sku'] = sku;
  _data['size'] = size;
  return _data;
  }
  }