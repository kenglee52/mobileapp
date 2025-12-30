import 'package:mobileapp/features/data/datasources/product_remote_datasource.dart';
import 'package:mobileapp/features/data/models/product_model.dart';
import 'package:mobileapp/features/domain/entities/product.dart';
import 'package:mobileapp/features/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remote;
  ProductRepositoryImpl(this.remote);

  @override
  Future<List<Product>> getProducts() => remote.getProducts();

  @override
  Future<void> createProduct(Product product) {
    final model = ProductModel.fromEntity(product);
    return remote.createProduct(model);
  }

  @override
  Future<void> updateProduct(Product product) {
    final model = ProductModel.fromEntity(product);
    return remote.createProduct(model);
  }

  @override
  Future<void> deleteProduct(int id) => remote.deleteProduct(id);

  @override
  Future<Product?> getProductById(int id) => remote.getProductById(id);
}
