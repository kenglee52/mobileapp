import 'package:flutter/material.dart';
import 'package:mobileapp/features/data/datasources/category_remote_datasource.dart';
import 'package:mobileapp/features/data/datasources/customer_remote_datasource.dart';
import 'package:mobileapp/features/data/datasources/product_remote_datasource.dart';
import 'package:mobileapp/features/data/repositories/category_repository_impl.dart';
import 'package:mobileapp/features/data/repositories/customer_repository_impl.dart';
import 'package:mobileapp/features/data/repositories/product_repository_impl.dart';
import 'package:mobileapp/features/domain/usecases/category/create_category.dart';
import 'package:mobileapp/features/domain/usecases/category/delete_category.dart';
import 'package:mobileapp/features/domain/usecases/category/get_categories.dart';
import 'package:mobileapp/features/domain/usecases/category/get_category_by_id.dart';
import 'package:mobileapp/features/domain/usecases/category/update_category.dart';
import 'package:mobileapp/features/domain/usecases/customer/create_customer.dart';
import 'package:mobileapp/features/domain/usecases/customer/delete_customer.dart';
import 'package:mobileapp/features/domain/usecases/customer/get_customer_by_id.dart';
import 'package:mobileapp/features/domain/usecases/customer/get_customers.dart';
import 'package:mobileapp/features/domain/usecases/customer/update_customer.dart';
import 'package:mobileapp/features/domain/usecases/product/create_product.dart';
import 'package:mobileapp/features/domain/usecases/product/delete_product.dart';
import 'package:mobileapp/features/domain/usecases/product/get_product_by_id.dart';
import 'package:mobileapp/features/domain/usecases/product/get_products.dart';
import 'package:mobileapp/features/domain/usecases/product/update_product.dart';
import 'package:mobileapp/features/presentation/pages/login_page.dart';
import 'package:mobileapp/features/presentation/viewmodels/category_view_model.dart';
import 'package:mobileapp/features/presentation/viewmodels/customer_view_model.dart';
import 'package:mobileapp/features/presentation/viewmodels/product_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  final customerRemote = CustomerRemoteDatasource();
  final customerRepo = CustomerRepositoryImpl(customerRemote);

  final categoryRemote = CategoryRemoteDatasource();
  final categoryRepo = CategoryRepositoryImpl(categoryRemote);

  final productRemote = ProductRemoteDatasource();
  final productRepo = ProductRepositoryImpl(productRemote);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (_) => CustomerViewModel(
                getCustomersUsecase: GetCustomers(customerRepo),
                createCustomerUsecase: CreateCustomer(customerRepo),
                updateCustomerUsecase: UpdateCustomer(customerRepo),
                deleteCustomerUsecase: DeleteCustomer(customerRepo),
                getCustomerByIdUsecase: GetCustomerById(customerRepo),
              )..loadCustomers(),
        ),
        ChangeNotifierProvider(
          create:
              (_) => CategoryViewModel(
                getCategoriesUsecase: GetCategories(categoryRepo),
                createCategoryUsecase: CreateCategory(categoryRepo),
                updateCategoryUsecase: UpdateCategory(categoryRepo),
                deleteCategoryUsecase: DeleteCategory(categoryRepo),
                getCategoryByIdUsecase: GetCategoryById(categoryRepo),
              )..loadCategories(),
        ),
        ChangeNotifierProvider(
          create:
              (_) => ProductViewModel(
                getProductsUsecase: GetProducts(productRepo),
                createProductUsecase: CreateProduct(productRepo),
                updateProductUsecase: UpdateProduct(productRepo),
                deleteProductUsecase: DeleteProduct(productRepo),
                getProductByIdUsecase: GetProductById(productRepo),
              )..loadProducts(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce',
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
