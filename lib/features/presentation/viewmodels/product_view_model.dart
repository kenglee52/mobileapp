import 'package:flutter/material.dart';
import 'package:mobileapp/features/domain/entities/product.dart';
import 'package:mobileapp/features/domain/usecases/product/create_product.dart';
import 'package:mobileapp/features/domain/usecases/product/delete_product.dart';
import 'package:mobileapp/features/domain/usecases/product/get_product_by_id.dart';
import 'package:mobileapp/features/domain/usecases/product/get_products.dart';
import 'package:mobileapp/features/domain/usecases/product/update_product.dart';

class ProductViewModel extends ChangeNotifier {
  final GetProducts getProductsUsecase;
  final CreateProduct createProductUsecase;
  final UpdateProduct updateProductUsecase;
  final DeleteProduct deleteProductUsecase;
  final GetProductById getProductByIdUsecase;
  ProductViewModel({
    required this.getProductsUsecase,
    required this.createProductUsecase,
    required this.updateProductUsecase,
    required this.deleteProductUsecase,
    required this.getProductByIdUsecase,
  });

  List<Product> product = [];
  bool isLoading = true;

  Future<void> loadProducts() async {
    isLoading = true;
    notifyListeners();
    product = await getProductsUsecase();
    isLoading = false;
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    await createProductUsecase(product);
    await loadProducts();
  }

  Future<void> editProduct(Product product) async {
    await updateProductUsecase(product);
    await loadProducts();
  }

  Future<void> removeProduct(int id) async {
    await deleteProductUsecase(id);
    await loadProducts();
  }

  Future<void> loadProductById(int id) async {
    isLoading = true;
    notifyListeners();
    await getProductByIdUsecase(id);
    isLoading = false;
    notifyListeners();
  }
}
