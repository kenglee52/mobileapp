import 'package:flutter/material.dart';
import 'package:mobileapp/features/domain/entities/customer.dart';
import 'package:mobileapp/features/domain/usecases/customer/create_customer.dart';
import 'package:mobileapp/features/domain/usecases/customer/delete_customer.dart';
import 'package:mobileapp/features/domain/usecases/customer/get_customer_by_id.dart';
import 'package:mobileapp/features/domain/usecases/customer/get_customers.dart';
import 'package:mobileapp/features/domain/usecases/customer/update_customer.dart';

class CustomerViewModel extends ChangeNotifier {
  final GetCustomers getCustomersUsecase;
  final CreateCustomer createCustomerUsecase;
  final UpdateCustomer updateCustomerUsecase;
  final DeleteCustomer deleteCustomerUsecase;
  final GetCustomerById getCustomerByIdUsecase;
  CustomerViewModel({
    required this.getCustomersUsecase,
    required this.createCustomerUsecase,
    required this.updateCustomerUsecase,
    required this.deleteCustomerUsecase,
    required this.getCustomerByIdUsecase,
  });

  List<Customer> customer = [];
  bool isLoading = true;

  Future<void> loadCustomers() async {
    isLoading = true;
    notifyListeners();
    customer = await getCustomersUsecase();
    isLoading = false;
    notifyListeners();
  }

  Future<void> addCustomer(Customer customer) async {
    await createCustomerUsecase(customer);
    await loadCustomers();
  }

  Future<void> editCustomer(Customer customer) async {
    await updateCustomerUsecase(customer);
    await loadCustomers();
  }

  Future<void> removeCustomer(int id) async {
    await deleteCustomerUsecase(id);
    await loadCustomers();
  }

  Future<void> loadCustomerById(int id) async {
    isLoading = true;
    notifyListeners();
    await getCustomerByIdUsecase(id);
    isLoading = false;
    notifyListeners();
  }
}
