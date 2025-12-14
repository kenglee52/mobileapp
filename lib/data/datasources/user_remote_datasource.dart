import 'dart:convert';
import 'package:mobileapp/core/config/Api.dart';
import 'package:mobileapp/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserRemoteDatasource {
  final String url = Api.baseUrl;
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List data = await jsonDecode(response.body);
        return data.map((e) => UserModel.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<void> createUser(UserModel user) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(user.toJson())
      );
      if(response.statusCode == 201){
        print("Create user success");
      }
    } catch (e) {
      print(e);
    }
  }
  Future<void> updateUser(UserModel user) async {
    try {
      final response = await http.post(
        Uri.parse(url+"/${user.id}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(user.toJson())
      );
      if(response.statusCode == 200){
        print("Update user success");
      }
    } catch (e) {
      print(e);
    }
  }
  Future<void> deleteUser(int id) async {
    try {
      final response = await http.post(
        Uri.parse(url+"/${id}")
      );
      if(response.statusCode == 200){
        print("Delete user success");
      }
    } catch (e) {
      print(e);
    }
  }
}
