import 'package:mobileapp/features/domain/entities/bill.dart';

class BillModel extends Bill {
  BillModel({
    required super.billID,
    required super.customerID,
    required super.logistictType,
    required super.logisticName,
    super.billdate,
    super.send,
  });

  factory BillModel.fromEntity(Bill bill) {
    return BillModel(
      billID: bill.billID,
      customerID: bill.customerID,
      logistictType: bill.logistictType,
      logisticName: bill.logisticName,
      billdate: bill.billdate,
      send: bill.send,
    );
  }

  factory BillModel.fromJson(Map<String, dynamic> json) {
    return BillModel(
      billID: json["onlineBillID"],
      customerID: json["customerID"],
      logistictType: json["logisticType"],
      logisticName: json["logisticName"],
      billdate: json["onlineBillDate"],
      send: json["send"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "onlineBillID": billID,
      "customerID": customerID,
      "logisticType": logistictType,
      "logisticName": logisticName,
    };
  }
}
