import 'dart:convert';
import 'dart:developer';
import 'package:ecom_app/core/apis.dart';

import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../models/product_details.dart';

class ProductDetailService {
  static Future getProductDetails({required int id}) async {
    try {
      Uri url = Uri.parse("${Apis.productDetailUrl}$id");
      // print("${Apis.productDetailUrl}$id");
      var response = await http.get(url);
      // print(response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        return ProductDetailModel.fromJson(result);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static Future getSimilarProducts({required int id}) async {
    try {
      Uri url = Uri.parse("${Apis.similarProUrl}$id/related");
      // print("${Apis.similarProUrl}$id/related");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List result = (jsonDecode(response.body) as List);

        if (result.isNotEmpty) {
          return result.map((e) => ProductsModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
