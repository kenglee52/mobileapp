import 'package:mobileapp/features/domain/entities/customer.dart';

abstract class CustomerRepository {
  Future<List<Customer>> getCustomers();
  Future<void> createCustomer(Customer customer);
  Future<void> updateCustomer(Customer customer);
  Future<void> deleteCustomer(int id);
  Future<Customer?> getCustomerById(int id);
}
