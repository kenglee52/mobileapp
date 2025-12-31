import 'package:mobileapp/features/domain/entities/bill.dart';

abstract class BillRepository {
  Future<List<Bill>> getBills();
  Future<void> createBill(Bill bill);
  Future<void> updateBill(Bill bill);
  Future<void> deleteBill(int id);
  Future<Bill?> getBillById(int id);
}
