import 'package:mobileapp/features/domain/entities/product.dart';
import 'package:mobileapp/features/domain/repositories/product_repository.dart';

class GetProductById {
  final ProductRepository repository;
  GetProductById(this.repository);
  Future<Product?> call(int id) {
    return repository.getProductById(id);
  }
}
