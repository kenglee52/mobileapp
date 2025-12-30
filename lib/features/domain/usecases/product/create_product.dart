import 'package:mobileapp/features/domain/entities/product.dart';
import 'package:mobileapp/features/domain/repositories/product_repository.dart';

class CreateProduct {
  final ProductRepository repository;
  CreateProduct(this.repository);
  Future<void> call(Product product) {
    return repository.createProduct(product);
  }
}
