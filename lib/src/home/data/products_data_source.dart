//For now repository layer is not needed. Implement local data souce -> make repository layer.
import 'dart:convert';
import 'dart:io';

import 'package:buytx/core/common/singletons/cache_helper.dart';
import 'package:buytx/core/services/injection_container.dart';
import 'package:buytx/core/utils/constant/network_constants.dart';
import 'package:buytx/src/home/data/product.dart';
import 'package:http/http.dart' as http;

class RemoteProductsDataSource {
  final http.Client _client = http.Client();
  String? token = sl<CacheHelper>().getSessionToken();

  Future<List<Product>> getProductsBasedOnFilters() async {
    if (token == null) {
      //return error;
    }

    final response = await _client.get(
      Uri.parse(
        "https://professional-audrye-mohammedalakkhras-c3be0efd.koyeb.app/api/products?page=0",
      ),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print("Available Products Based On Filters: ${response.body}");

    final decodedResponse = jsonDecode(response.body);
    return decodedResponse["data"].map<Product>((e) {
      if (e["images"].runtimeType == String) {
        e["images"] = [
          {"high": e["images"], "low": e["images"], "mid": e["images"]},
        ];
        print(e["images"].first["mid"]);
        print(e["images"].first["low"]);
        print(e["images"].first["high"]);
      }
      return Product.fromJson(e);
    }).toList();
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse('${NetworkConstants.baseUrl}products/');
    final response = await _client.post(
      url,
      body: jsonEncode(product.toJson()),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print(response.body);
  }
}
