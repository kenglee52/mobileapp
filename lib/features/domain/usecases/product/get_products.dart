import 'package:mobileapp/features/domain/entities/product.dart';
import 'package:mobileapp/features/domain/repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;
  GetProducts(this.repository);
  Future<List<Product>> call() {
    return repository.getProducts();
  }
}
