import 'package:flutter/material.dart';
import 'package:mobileapp/features/domain/entities/bill.dart';
import 'package:mobileapp/features/domain/usecases/bill/create_bill.dart';
import 'package:mobileapp/features/domain/usecases/bill/delete_bill.dart';
import 'package:mobileapp/features/domain/usecases/bill/get_bill_by_id.dart';
import 'package:mobileapp/features/domain/usecases/bill/get_bills.dart';
import 'package:mobileapp/features/domain/usecases/bill/update_bill.dart';

class BillViewModel extends ChangeNotifier {
  final GetBills getBillsUsecase;
  final CreateBill createBillUsecase;
  final UpdateBill updateBillUsecase;
  final DeleteBill deleteBillUsecase;
  final GetBillById getBillByIdUsecase;
  BillViewModel({
    required this.getBillsUsecase,
    required this.createBillUsecase,
    required this.updateBillUsecase,
    required this.deleteBillUsecase,
    required this.getBillByIdUsecase,
  });

  List<Bill> bill = [];
  bool isLoading = true;

  Future<void> loadBills() async {
    isLoading = true;
    notifyListeners();
    bill = await getBillsUsecase();
    isLoading = false;
    notifyListeners();
  }

  Future<void> addBill(Bill bill) async {
    await createBillUsecase(bill);
    await loadBills();
  }

  Future<void> editBill(Bill bill) async {
    await updateBillUsecase(bill);
    await loadBills();
  }

  Future<void> removeBill(int id) async {
    await deleteBillUsecase(id);
    await loadBills();
  }

  Future<void> loadBillById(int id) async {
    isLoading = true;
    notifyListeners();
    await getBillByIdUsecase(id);
    isLoading = false;
    notifyListeners();
  }
}
