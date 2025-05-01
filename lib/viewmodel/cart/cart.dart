import 'package:ecom_app/model/models/product.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<ProductsModel> cartList = [];
  List<ProductsModel> get getCartList => cartList;

  removeFromCart(id) {
    cartList.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  addtoCart(ProductsModel data) {
    cartList.add(data);
    notifyListeners();
  }

  isAdded(id) {
    return cartList.where((e) => e.id == id).toList().isNotEmpty;
  }

  getTotalAmount() {
    int sum = 0;
    for (var e in cartList) {
      sum += e.price ?? 0;
    }
    return sum;
  }

  toPay() {
    return getTotalAmount() + 100 + 140 + 5.6;
  }
}
