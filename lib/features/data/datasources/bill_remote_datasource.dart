import 'dart:convert';

import 'package:mobileapp/core/config/Api.dart';
import 'package:http/http.dart' as http;
import 'package:mobileapp/features/data/models/bill_model.dart';

class BillRemoteDatasource {
  final String url = Api.baseUrl + "/online_bill";
  Future<List<BillModel>> getBills() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List data = await jsonDecode(response.body);
        return data.map((e) => BillModel.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<int?> createBill(BillModel bill) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(bill.toJson()),
      );
      if (response.statusCode == 201) {
        final data = await jsonDecode(response.body);
        int id = data["data"]["onlineBillID"];
        print(id);
        return id;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> updateBill(BillModel bill) async {
    try {
      final response = await http.put(
        Uri.parse(url + "/${bill.billID}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(bill.toJson()),
      );
      if (response.statusCode == 200) {
        print("Update bill success");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteBill(int id) async {
    try {
      final response = await http.delete(Uri.parse(url + "/${id}"));
      if (response.statusCode == 200) {
        print("Update bill success");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<BillModel?> getBillById(int id) async {
    try {
      final response = await http.get(Uri.parse(url + "/${id}"));
      if (response.statusCode == 200) {
        final data = await jsonDecode(response.body);
        return BillModel.fromJson(data);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
