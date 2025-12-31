import 'package:mobileapp/features/domain/entities/bill.dart';
import 'package:mobileapp/features/domain/repositories/bill_repository.dart';

class GetBillById {
  final BillRepository repository;
  GetBillById(this.repository);
  Future<Bill?> call(int id) {
    return repository.getBillById(id);
  }
}
