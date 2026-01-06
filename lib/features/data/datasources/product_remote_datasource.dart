import 'dart:convert';
import 'package:mobileapp/core/config/Api.dart';
import 'package:mobileapp/features/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRemoteDatasource {
  final String url = Api.baseUrl + "/product";
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List data = await jsonDecode(response.body);
        return data.map((e) => ProductModel.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<void> createProduct(ProductModel product) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(product.toJson()),
      );
      if (response.statusCode == 201) {
        print("Create product success");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      final response = await http.put(
        Uri.parse(url + "/${product.productID}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(product.toJson()),
      );
      if (response.statusCode == 200) {
        print("Update product success");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      final response = await http.delete(Uri.parse(url + "/${id}"));
      if (response.statusCode == 200) {
        print("Delete product success");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<ProductModel?> getProductById(int id) async {
    try {
      final response = await http.get(Uri.parse(url + "/${id}"));
      if (response.statusCode == 200) {
        final data = await jsonDecode(response.body);
        return ProductModel.fromJson(data);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
