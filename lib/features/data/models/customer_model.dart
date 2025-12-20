import 'package:mobileapp/features/domain/entities/customer.dart';

class CustomerModel extends Customer {
  CustomerModel({
    required super.customerID,
    required super.customerName,
    required super.customerTel,
    required super.customerPassword,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      customerID: json["customerID"],
      customerName: json["customerName"],
      customerTel: json["customerTel"],
      customerPassword: json["customerPassword"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "customerID": customerID,
      "customerName": customerName,
      "customerTel": customerTel,
      "customerPassword": customerPassword,
    };
  }
}
