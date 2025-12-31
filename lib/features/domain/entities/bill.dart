class Bill {
  final int? billID;
  final int customerID;
  final String logistictType;
  final String logisticName;
  final String? billdate;
  final bool? send;
  Bill({
    required this.billID,
    required this.customerID,
    required this.logistictType,
    required this.logisticName,
    required this.billdate,
    required this.send,
  });
}
