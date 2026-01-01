import 'dart:convert';

import 'package:mobileapp/core/config/Api.dart';
import 'package:http/http.dart' as http;
import 'package:mobileapp/features/data/models/order_model.dart';

class OrderRemoteDatasource {
  final String url = Api.baseUrl + "/online_order";
  Future<List<OrderModel>> getOrders() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List data = await jsonDecode(response.body);
        return data.map((e) => OrderModel.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<void> createOrder(OrderModel order) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(order.toJson()),
      );
      if (response.statusCode == 201) {
        print("Create order success");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateOrder(OrderModel order) async {
    try {
      final response = await http.put(
        Uri.parse(url + "/${order.orderID}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(order.toJson()),
      );
      if (response.statusCode == 200) {
        print("Update order success");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteOrder(int id) async {
    try {
      final response = await http.delete(Uri.parse(url + "/${id}"));
      if (response.statusCode == 200) {
        print("Delete order success");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<OrderModel?> getOrderById(int id) async {
    try {
      final response = await http.delete(Uri.parse(url + "/${id}"));
      if (response.statusCode == 200) {
        final data = await jsonDecode(response.body);
        return OrderModel.fromJson(data);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
