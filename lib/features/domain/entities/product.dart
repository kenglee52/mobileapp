import 'package:mobileapp/features/domain/entities/category.dart';
import 'package:mobileapp/features/domain/entities/unit.dart';

class Product {
  final int? productID;
  final String productName;
  final int categoryID;
  final int unitID;
  final int stockQty;
  final int price;
  final String image;
  final int importPrice;
  final String? manufature;
  final String? expiry;
  final String? description;
  final Category category;
  final Unit unit;
  Product({
    required this.productID,
    required this.productName,
    required this.categoryID,
    required this.unitID,
    required this.stockQty,
    required this.price,
    required this.image,
    required this.importPrice,
    required this.manufature,
    required this.expiry,
    required this.description,
    required this.category,
    required this.unit
  });
}
