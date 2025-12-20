import 'package:mobileapp/features/domain/entities/category.dart';
import 'package:mobileapp/features/domain/repositories/category_repository.dart';

class GetCategoryById {
  final CategoryRepository repository;
  GetCategoryById(this.repository);
  Future<Category?> call(int id) {
    return repository.getCategoryById(id);
  }
}
