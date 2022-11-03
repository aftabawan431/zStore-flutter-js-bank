import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/globals/globals.dart';
import '../../data/models/cart_model.dart';
import 'db_helper.dart';

class CartProvider with ChangeNotifier {
  DBHelper db = DBHelper();
  int _counter = 0;
  int get counter => _counter;

  int _totalPrice = 0;
  int get totalPrice => _totalPrice;

  late List<Cart> _cart;
  List<Cart> get cart => _cart;
  ValueNotifier<bool> isLoadingNotifier = ValueNotifier(true);

  int getTotalPriceReduced(){
    return (cart.map((e) => e.productPrice!*e.quantity!).reduce((value, element) => value+element) + 230).toInt();
  }

  Future<List<Cart>> getData() async {
    isLoadingNotifier.value = true;
    _cart = await db.getCartList();
    isLoadingNotifier.value = false;
    return _cart;
  }

  void addQuantity(int index) async {
    print(cart[index].quantity!);
    cart[index].quantity =cart[index].quantity!+1;
    print(cart[index].quantity!);
    print('aftab1');
    db.updateQuantity(Cart(
            productId: cart[index].productId!.toString(),
            productName: cart[index].productName!,
            productPrice: cart[index].productPrice ,
            quantity: cart[index].quantity!,
            image: cart[index].image.toString(), sku: ''))
        .then((value) {
      print('aftab2');


    }).onError((error, stackTrace) {
      print('aftab3');

      print(error.toString());
    });
    notifyListeners();
  }
  void removeQuantity(int index) async {
    cart[index].quantity =cart[index].quantity!-1;

    print('aftab1');
    db.updateQuantity(Cart(
            productId: cart[index].productId!.toString(),
            productName: cart[index].productName!,
            productPrice: cart[index].productPrice,
            quantity: cart[index].quantity!,
            image: cart[index].image.toString(), sku: ''))
        .then((value) {
      print('aftab2');

      // cart[index].productPrice  = 0;
      if(cart[index].quantity ==0){
        db.delete(
            cart[index]
                .productId!);
       removerCounter();
       cart.removeAt(index);
        notifyListeners();
      }

    }).onError((error, stackTrace) {
      print('aftab3');

      print(error.toString());
    });
    notifyListeners();
  }

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setInt('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalPrice = prefs.getInt('total_price') ?? 0;
    notifyListeners();
  }

   delAll()async{
    DBHelper db = sl();
    await db.deleteAll();
    notifyListeners();
  }

  int getTotalPrice() {
    _getPrefItems();
    return _totalPrice;
  }

  void addCounter() {
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void removerCounter() {
    _counter--;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefItems();
    return _counter;
  }
  // set counter({int val=0}){
  //   _counter=val;
  //   notifyListeners();
  //
  // }
  emptyCounter()async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setInt('cart_item', 0);
    notifyListeners();
    // return _counter;
  }
}
