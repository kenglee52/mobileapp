import 'package:mobileapp/features/domain/entities/order.dart';

class OrderModel extends Order {
  OrderModel({
    required super.orderID,
    required super.billID,
    required super.productID,
    required super.saleQty,
    required super.total,
  });

  factory OrderModel.fromEntity(Order order) {
    return OrderModel(
      orderID: order.orderID,
      billID: order.billID,
      productID: order.productID,
      saleQty: order.saleQty,
      total: order.total,
    );
  }
  
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderID: json["onlineOrderID"],
      billID: json["onlineBillID"],
      productID: json["productID"],
      saleQty: json["saleQty"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "onlineOrderID": orderID,
      "onlineBillID": billID,
      "productID": productID,
      "saleQty": saleQty,
      "total": total,
    };
  }
}
