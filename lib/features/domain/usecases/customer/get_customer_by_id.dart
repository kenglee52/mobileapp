import 'package:mobileapp/features/domain/entities/customer.dart';
import 'package:mobileapp/features/domain/repositories/customer_repository.dart';

class GetCustomerById {
  final CustomerRepository repository;
  GetCustomerById(this.repository);
  Future<Customer?> call(int id) {
    return repository.getCustomerById(id);
  }
}
