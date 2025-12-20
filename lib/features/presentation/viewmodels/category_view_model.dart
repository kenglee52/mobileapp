import 'package:flutter/material.dart';
import 'package:mobileapp/features/domain/entities/category.dart';
import 'package:mobileapp/features/domain/usecases/category/create_category.dart';
import 'package:mobileapp/features/domain/usecases/category/delete_category.dart';
import 'package:mobileapp/features/domain/usecases/category/get_categories.dart';
import 'package:mobileapp/features/domain/usecases/category/get_category_by_id.dart';
import 'package:mobileapp/features/domain/usecases/category/update_category.dart';

class CategoryViewModel extends ChangeNotifier {
  final GetCategories getCategoriesUsecase;
  final CreateCategory createCategoryUsecase;
  final UpdateCategory updateCategoryUsecase;
  final DeleteCategory deleteCategoryUsecase;
  final GetCategoryById getCategoryByIdUsecase;
  CategoryViewModel({
    required this.getCategoriesUsecase,
    required this.createCategoryUsecase,
    required this.updateCategoryUsecase,
    required this.deleteCategoryUsecase,
    required this.getCategoryByIdUsecase,
  });

  List<Category> category = [];
  bool isLoading = true;

  Future<void> loadCategories() async {
    isLoading = true;
    notifyListeners();
    category = await getCategoriesUsecase();
    isLoading = false;
    notifyListeners();
  }

  Future<void> addCategory(Category category) async {
    await createCategoryUsecase(category);
    await loadCategories();
  }

  Future<void> editCategory(Category category) async {
    await updateCategoryUsecase(category);
    await loadCategories();
  }

  Future<void> removeCategory(int id) async {
    await deleteCategoryUsecase(id);
    await loadCategories();
  }

  Future<void> getCategoryById(int id) async {
    isLoading = true;
    notifyListeners();
    await getCategoryByIdUsecase(id);
    isLoading = false;
    notifyListeners();
  }
}
