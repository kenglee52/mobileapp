import 'package:mobileapp/features/data/models/category_model.dart';
import 'package:mobileapp/features/data/models/unit_model.dart';
import 'package:mobileapp/features/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.productID,
    required super.productName,
    required super.categoryID,
    required super.unitID,
    required super.stockQty,
    required super.price,
    required super.image,
    required super.importPrice,
    super.manufature,
    super.expiry,
    super.description,
    required super.category,
    required super.unit,
  });
  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      productID: product.productID,
      productName: product.productName,
      categoryID: product.categoryID,
      unitID: product.unitID,
      stockQty: product.stockQty,
      price: product.price,
      image: product.image,
      importPrice: product.importPrice,
      manufature: product.manufature,
      expiry: product.expiry,
      description: product.description,
      category: product.category,
      unit: product.unit,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productID: json["productID"],
      productName: json["productName"],
      categoryID: json["categoryID"],
      unitID: json["unitID"],
      stockQty: json["stockQty"],
      price: json["price"],
      image: json["image"],
      importPrice: json["importPrice"],
      manufature: json["manufature"],
      expiry: json["expiry"],
      description: json["description"],
      category: CategoryModel.fromJson(json["category"] as Map<String, dynamic>),
      unit: UnitModel.fromJson(json["unit"] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "productID": productID,
      "productName": productName,
      "categoryID": categoryID,
      "unitID": unitID,
      "stockQty": stockQty,
      "price": price,
      "image": image,
      "importPrice": importPrice,
      "manufature": manufature,
      "expiry": expiry,
      "description": description,
    };
  }
}
