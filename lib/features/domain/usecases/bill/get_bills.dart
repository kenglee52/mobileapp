import 'package:mobileapp/features/domain/entities/bill.dart';
import 'package:mobileapp/features/domain/repositories/bill_repository.dart';

class GetBills {
  final BillRepository repository;
  GetBills(this.repository);
  Future<List<Bill>> call() {
    return repository.getBills();
  }
}
