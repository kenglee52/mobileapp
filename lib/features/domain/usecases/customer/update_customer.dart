import 'package:mobileapp/features/domain/entities/customer.dart';
import 'package:mobileapp/features/domain/repositories/customer_repository.dart';

class UpdateCustomer {
  final CustomerRepository repository;
  UpdateCustomer(this.repository);
  Future<void> call(Customer customer) {
    return repository.updateCustomer(customer);
  }
}
