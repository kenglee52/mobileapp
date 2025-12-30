import 'package:mobileapp/features/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<void> createProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(int id);
  Future<Product?> getProductById(int id);
}
