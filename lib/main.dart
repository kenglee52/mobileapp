import 'package:flutter/material.dart';
import 'package:mobileapp/features/data/datasources/customer_remote_datasource.dart';
import 'package:mobileapp/features/data/repositories/customer_repository_impl.dart';
import 'package:mobileapp/features/domain/usecases/customer/create_customer.dart';
import 'package:mobileapp/features/domain/usecases/customer/delete_customer.dart';
import 'package:mobileapp/features/domain/usecases/customer/get_customer_by_id.dart';
import 'package:mobileapp/features/domain/usecases/customer/get_customers.dart';
import 'package:mobileapp/features/domain/usecases/customer/update_customer.dart';
import 'package:mobileapp/features/presentation/pages/register_page.dart';
import 'package:mobileapp/features/presentation/viewmodels/customer_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  final remote = CustomerRemoteDatasource();
  final repo = CustomerRepositoryImpl(remote);
  runApp(
    ChangeNotifierProvider(
      create:
          (context) => CustomerViewModel(
            getCustomersUsecase: GetCustomers(repo),
            createCustomerUsecase: CreateCustomer(repo),
            updateCustomerUsecase: UpdateCustomer(repo),
            deleteCustomerUsecase: DeleteCustomer(repo),
            getCustomerByIdUsecase: GetCustomerById(repo),
          )..loadCustomers(),
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
      home: const RegisterPage(),
    );
  }
}
