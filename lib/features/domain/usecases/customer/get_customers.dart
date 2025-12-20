import 'package:mobileapp/features/domain/entities/customer.dart';
import 'package:mobileapp/features/domain/repositories/customer_repository.dart';

class GetCustomers {
  final CustomerRepository repository;
  GetCustomers(this.repository);
  Future<List<Customer>> call() {
    return repository.getCustomers();
  }
}
