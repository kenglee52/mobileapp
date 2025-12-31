import 'package:mobileapp/features/data/datasources/bill_remote_datasource.dart';
import 'package:mobileapp/features/data/models/bill_model.dart';
import 'package:mobileapp/features/domain/entities/bill.dart';
import 'package:mobileapp/features/domain/repositories/bill_repository.dart';

class BillRepositoryImpl implements BillRepository {
  final BillRemoteDatasource remote;
  BillRepositoryImpl(this.remote);

  @override
  Future<List<Bill>> getBills() => remote.getBills();

  @override
  Future<void> createBill(Bill bill) {
    final model = BillModel.fromEntity(bill);
    return remote.createBill(model);
  }

  @override
  Future<void> updateBill(Bill bill) {
    final model = BillModel.fromEntity(bill);
    return remote.updateBill(model);
  }

  @override
  Future<void> deleteBill(int id) => remote.deleteBill(id);

  @override
  Future<Bill?> getBillById(int id) => remote.getBillById(id);
}
