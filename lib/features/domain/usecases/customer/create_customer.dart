import 'package:mobileapp/features/domain/entities/customer.dart';
import 'package:mobileapp/features/domain/repositories/customer_repository.dart';

class CreateCustomer {
  final CustomerRepository repository;
  CreateCustomer(this.repository);
  Future<void> call(Customer customer) {
    return repository.createCustomer(customer);
  }
}
