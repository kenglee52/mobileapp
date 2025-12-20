import 'package:mobileapp/features/domain/repositories/customer_repository.dart';

class DeleteCustomer {
  final CustomerRepository repository;
  DeleteCustomer(this.repository);
  Future<void> call(int id) {
    return repository.deleteCustomer(id);
  }
}
