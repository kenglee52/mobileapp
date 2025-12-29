import 'package:mobileapp/features/data/datasources/category_remote_datasource.dart';
import 'package:mobileapp/features/data/models/category_model.dart';
import 'package:mobileapp/features/domain/entities/category.dart';
import 'package:mobileapp/features/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDatasource remote;
  CategoryRepositoryImpl(this.remote);

  @override
  Future<List<Category>> getCategories() => remote.getCategories();

  @override
  Future<void> createCategory(Category category) {
    final model = CategoryModel.fromEntity(category);
    return remote.createCategory(model);
  }

  @override
  Future<void> updateCategory(Category category) {
    final model = CategoryModel.fromEntity(category);
    return remote.updateCategory(model);
  }

  @override
  Future<void> deleteCategory(int id) => remote.deleteCategory(id);

  @override
  Future<Category?> getCategoryById(int id) => remote.getCategoryById(id);
}
