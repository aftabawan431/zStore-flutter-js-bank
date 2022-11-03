class Cart {

   String? productId;
   String? productName;
   String? sku;
   int? productPrice;
   int? quantity;
   String? image;

  Cart({
    required this.productId,
    required this.productName,
    required this.sku,
    required this.productPrice,
    required this.quantity,
    required this.image
  });

  Cart.fromMap(Map<dynamic , dynamic>  res)
  :
  productId = res["productId"],
  productName = res["productName"],
  sku = res["sku"],
  productPrice = res["productPrice"],
  quantity = res["quantity"],
  image = res["image"];

  Map<String, Object?> toMap(){
    return {
      'productId' : productId,
      'productName' :productName,
      'sku' :sku,
      'productPrice' : productPrice,
      'quantity' : quantity,
      'image' : image,
    };
  }
}
