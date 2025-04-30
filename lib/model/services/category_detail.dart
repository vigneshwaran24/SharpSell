import 'dart:convert';
import 'dart:developer';

import '../../core/apis.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class CategoryDetailService {
  static Future getCategoryDetails({required int id}) async {
    try {
      Uri url =
          Uri.parse("${Apis.categoryDetailUrl}$id/products?limit=10&offset=0");

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
