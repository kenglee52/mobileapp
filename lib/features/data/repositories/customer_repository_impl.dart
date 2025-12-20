import 'package:mobileapp/features/data/datasources/customer_remote_datasource.dart';
import 'package:mobileapp/features/data/models/customer_model.dart';
import 'package:mobileapp/features/domain/entities/customer.dart';
import 'package:mobileapp/features/domain/repositories/customer_repository.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDatasource remote;
  CustomerRepositoryImpl(this.remote);

  @override
  Future<List<Customer>> getCustomers() => remote.getCustomers();

  @override
  Future<void> createCustomer(Customer customer) {
    return remote.createCustomer(customer as CustomerModel);
  }

  @override
  Future<void> updateCustomer(Customer customer) {
    return remote.updateCustomer(customer as CustomerModel);
  }

  @override
  Future<void> deleteCustomer(int id) => remote.deleteCustomer(id);

  @override
  Future<Customer?> getCustomerById(int id) => remote.getCustomerById(id);
}
