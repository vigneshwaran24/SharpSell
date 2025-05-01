import 'package:ecom_app/model/models/categorie.dart';
import 'package:ecom_app/model/models/product.dart';
import 'package:ecom_app/model/services/home.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool productLoading = false;
  bool categorieLoading = false;
  bool productMore = true;
  bool categorieMore = false;
  final List<ProductsModel> _productsList = [];
  final List<CategorieModel> _categoriesList = [];

  int productLimit = 10;
  int productOffset = 0;

  Future fetchProducts({bool loadMore = false}) async {
    if (productLoading) return;
    if (!loadMore) {
      productLimit = 10;
      productOffset = 0;
      _productsList.clear();
      productMore = true;
    }
    productLoading = true;
    // notifyListeners();
    var result = await HomeService.getProducts(
        limit: productLimit, offset: productOffset);

    if (result == null) return;
    productLoading = false;

    if ((result as List<ProductsModel>).isNotEmpty) {
      _productsList.addAll(result);
      productLimit += 10;
      productOffset += 1;
      productMore = true;
      notifyListeners();
    } else {
      productMore = false;
      notifyListeners();
    }
  }

  List<ProductsModel> get getProductsList => _productsList;
  int categorieLimit = 10;
  Future fetchCategories({bool loadMore = false}) async {
    if (categorieLoading) return;
    if (!loadMore) {
      categorieLimit = 10;
      _categoriesList.clear();
      categorieMore = true;
    }
    categorieLoading = true;

    var result = await HomeService.getCategories(limit: categorieLimit);

    if (result == null) return;
    if ((result as List<CategorieModel>).isNotEmpty) {
      _categoriesList.addAll(result);
      categorieLimit += 10;

      categorieMore = true;
      notifyListeners();
    } else {
      categorieMore = false;
      notifyListeners();
    }
  }

  List<CategorieModel> get getCategoriesList => _categoriesList;

  List<ProductsModel> searchList = [];
  getSearchList(String search) {
    searchList = _productsList
        .where((e) =>
            e.title?.toLowerCase().contains(search.toLowerCase()) ?? false)
        .toList();
    notifyListeners();
  }
}
