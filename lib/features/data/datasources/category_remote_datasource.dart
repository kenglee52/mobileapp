import 'dart:convert';

import 'package:mobileapp/core/config/Api.dart';
import 'package:mobileapp/features/data/models/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryRemoteDatasource {
  final String url = Api.baseUrl + "/category";
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List data = await jsonDecode(response.body);
        return data.map((e) => CategoryModel.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<void> createCategory(CategoryModel category) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(category.toJson()),
      );
      if (response.statusCode == 201) {
        print("Create category success");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateCategory(CategoryModel category) async {
    try {
      final response = await http.put(
        Uri.parse(url + "/${category.categoryID}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(category.toJson()),
      );
      if (response.statusCode == 200) {
        print("Update category success");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      final response = await http.delete(Uri.parse(url + "/${id}"));
      if (response.statusCode == 200) {
        print("Delete category success");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<CategoryModel?> getCategoryById(int id) async {
    try {
      final response = await http.get(Uri.parse(url + "/${id}"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return CategoryModel.fromJson(data);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
