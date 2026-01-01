import 'package:flutter/material.dart';
import 'package:mobileapp/features/domain/entities/order.dart';
import 'package:mobileapp/features/domain/usecases/order/create_order.dart';
import 'package:mobileapp/features/domain/usecases/order/delete_order.dart';
import 'package:mobileapp/features/domain/usecases/order/get_order_by_id.dart';
import 'package:mobileapp/features/domain/usecases/order/get_orders.dart';
import 'package:mobileapp/features/domain/usecases/order/update_order.dart';

class OrderViewModel extends ChangeNotifier {
  final GetOrders getOrdersUsecase;
  final CreateOrder createOrderUsecase;
  final UpdateOrder updateOrderUsecase;
  final DeleteOrder deleteOrderUsecase;
  final GetOrderById getOrderByIdUsecase;
  OrderViewModel({
    required this.getOrdersUsecase,
    required this.createOrderUsecase,
    required this.updateOrderUsecase,
    required this.deleteOrderUsecase,
    required this.getOrderByIdUsecase,
  });

  List<Order> order = [];
  bool isLoading = true;

  Future<void> loadOrders() async {
    isLoading = true;
    notifyListeners();
    order = await getOrdersUsecase();
    isLoading = false;
    notifyListeners();
  }

  Future<void> addOrder(Order order) async {
    await createOrderUsecase(order);
    loadOrders();
  }

  Future<void> editOrder(Order order) async {
    await updateOrderUsecase(order);
    loadOrders();
  }

  Future<void> removeOrder(int id) async {
    await deleteOrderUsecase(id);
    loadOrders();
  }

  Future<void> loadOrderById(int id) async {
    isLoading = true;
    notifyListeners();
    await getOrderByIdUsecase(id);
    isLoading = false;
    notifyListeners();
  }
}
