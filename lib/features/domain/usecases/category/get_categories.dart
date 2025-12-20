import 'package:mobileapp/features/domain/entities/category.dart';
import 'package:mobileapp/features/domain/repositories/category_repository.dart';

class GetCategories {
  final CategoryRepository repository;
  GetCategories(this.repository);
  Future<List<Category>> call() {
    return repository.getCategories();
  }
}
