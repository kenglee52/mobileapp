import 'dart:convert';
import 'package:mobileapp/core/config/Api.dart';
import 'package:mobileapp/features/data/models/customer_model.dart';
import 'package:http/http.dart' as http;

class CustomerRemoteDatasource {
  final String url = Api.baseUrl + "/customer";
  Future<List<CustomerModel>> getCustomers() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List data = await jsonDecode(response.body);
        return data.map((e) => CustomerModel.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<void> createCustomer(CustomerModel customer) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(customer.toJson()),
      );
      if (response.statusCode == 201) {
        print("Create customer success");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateCustomer(CustomerModel customer) async {
    try {
      final response = await http.put(
        Uri.parse(url + "${customer.customerID}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(customer.toJson()),
      );
      if (response.statusCode == 200) {
        print("Update customer success");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteCustomer(int id) async {
    try {
      final response = await http.delete(Uri.parse(url + "/${id}"));
      if (response.statusCode == 200) {
        print("Delete customer success");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<CustomerModel?> getCustomerById(int id) async {
    try {
      final response = await http.get(Uri.parse(url + "/${id}"));
      if (response.statusCode == 200) {
        final data = await jsonDecode(response.body);
        return CustomerModel.fromJson(data);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
