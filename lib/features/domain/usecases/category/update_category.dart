import 'package:mobileapp/features/domain/entities/category.dart';
import 'package:mobileapp/features/domain/repositories/category_repository.dart';

class UpdateCategory {
  final CategoryRepository repository;
  UpdateCategory(this.repository);
  Future<void> call(Category category) {
    return repository.updateCategory(category);
  }
}
