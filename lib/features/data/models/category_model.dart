import 'package:mobileapp/features/domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({required super.categoryID, required super.categoryName});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryID: json["categoryID"],
      categoryName: json["categoryName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"categoryID": categoryID, "categoryName": categoryName};
  }
}
