import 'dart:convert';
import 'package:mobileapp/core/config/Api.dart';
import 'package:http/http.dart' as http;

class Report {
  static List<Map<String, dynamic>> bestProduct = [];
  static List<Map<String, dynamic>> bill = [];
  static List<Map<String, dynamic>> orders = [];
  bool isloading = true;
  static final String url = Api.baseUrl + "/report";

  static Future<void> fetchBestProduct() async {
    try {
      final response = await http.get(Uri.parse("$url/best-product"));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);

        bestProduct =
            jsonList.map((e) => Map<String, dynamic>.from(e)).toList();

        print("fetch best product success");
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  static Future<void> fetchBill(int id) async {
    try {
      final response = await http.get(Uri.parse("${url}/online_bill/${id}"));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = await jsonDecode(response.body);
        bill = responseData.map((e) => Map<String, dynamic>.from(e)).toList();
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> fetchOrder(int id) async {
    try {
      final response = await http.get(Uri.parse("${url}/online_order/${id}"));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = await jsonDecode(response.body);
        orders = responseData.map((e) => Map<String, dynamic>.from(e)).toList();
      }
    } catch (e) {
      print(e);
    }
  }
}
