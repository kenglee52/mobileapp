import 'package:mobileapp/features/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<void> createCategory(Category category);
  Future<void> updateCategory(Category category);
  Future<void> deleteCategory(int id);
  Future<Category?> getCategoryById(int id);
}
