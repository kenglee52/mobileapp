import 'package:mobileapp/features/domain/repositories/bill_repository.dart';

class DeleteBill {
  final BillRepository repository;
  DeleteBill(this.repository);
  Future<void> call(int id) {
    return repository.deleteBill(id);
  }
}
