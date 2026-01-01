class Order {
  final int? orderID;
  final int billID;
  final int productID;
  final int? saleQty;
  final int? total;
  Order({
    required this.orderID,
    required this.billID,
    required this.productID,
    required this.saleQty,
    required this.total,
  });
}
