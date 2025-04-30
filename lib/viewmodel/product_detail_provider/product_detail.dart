import 'package:ecom_app/model/models/product_details.dart';
import 'package:ecom_app/model/services/product_detail.dart';
import 'package:flutter/material.dart';

import '../../model/models/product.dart';

class ProductDetailProvider extends ChangeNotifier {
  bool isLoading = false;
  ProductDetailModel? details;
  ProductDetailModel? get getDetails => details;
  Future fetchDetails({required int id}) async {
    details = null;
    isLoading = true;
    var result = await ProductDetailService.getProductDetails(id: id);
    if (result == null) return;
    isLoading = false;
    details = result;
    notifyListeners();
  }

  List<ProductsModel> similarProducts = [];
  List<ProductsModel> get getSimilarProducts => similarProducts;
  Future fetchSimilarProducts({required int id}) async {
    similarProducts = [];
    var result = await ProductDetailService.getSimilarProducts(id: id);
    if (result == null) return;
    similarProducts = result;
    notifyListeners();
  }
}
