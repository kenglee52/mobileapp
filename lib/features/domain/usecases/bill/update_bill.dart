import 'package:mobileapp/features/domain/entities/bill.dart';
import 'package:mobileapp/features/domain/repositories/bill_repository.dart';

class UpdateBill {
  final BillRepository repository;
  UpdateBill(this.repository);
  Future<void> call(Bill bill) {
    return repository.updateBill(bill);
  }
}
