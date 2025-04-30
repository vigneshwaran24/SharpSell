import 'package:ecom_app/model/models/product.dart';
import 'package:ecom_app/model/services/category_detail.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  bool isLoading = false;

  List<ProductsModel> productList = [];
  List<ProductsModel> get getProductList => productList;
  fetchProducts({required int id}) async {
    isLoading = true;
    var result = await CategoryDetailService.getCategoryDetails(id: id);
    isLoading = false;
    notifyListeners();
    if (result == null) return;

    productList = result;
    notifyListeners();
  }
}
