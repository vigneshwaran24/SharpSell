import 'dart:convert';
import 'package:ecom_app/core/apis.dart';
import 'package:ecom_app/model/models/product.dart';
import 'package:http/http.dart' as http;

import '../models/categorie.dart';

class HomeService {
  static Future getProducts({required int limit, required int offset}) async {
    try {
      Uri url = Uri.parse(Apis.productsUrl)
          .replace(queryParameters: {"limit": "$limit", "offset": "$offset"});
      print(url.queryParameters);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List result = (jsonDecode(response.body) as List);

        if (result.isNotEmpty) {
          return result.map((e) => ProductsModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future getCategories({required int limit}) async {
    try {
      print(limit);
      Uri url = Uri.parse(Apis.categorieUrl)
          .replace(queryParameters: {"limit": "$limit"});
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List result = (jsonDecode(response.body) as List);
        if (result.isNotEmpty) {
          return result.map((e) => CategorieModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
