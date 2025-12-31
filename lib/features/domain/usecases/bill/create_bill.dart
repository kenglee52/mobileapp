import 'package:mobileapp/features/domain/entities/bill.dart';
import 'package:mobileapp/features/domain/repositories/bill_repository.dart';

class CreateBill {
  final BillRepository repository;
  CreateBill(this.repository);
  Future<void> call(Bill bill) {
    return repository.createBill(bill);
  }
}
