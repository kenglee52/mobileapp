import 'package:mobileapp/features/data/datasources/order_remote_datasource.dart';
import 'package:mobileapp/features/data/models/order_model.dart';
import 'package:mobileapp/features/domain/entities/order.dart';
import 'package:mobileapp/features/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDatasource remote;
  OrderRepositoryImpl(this.remote);

  @override
  Future<List<Order>> getOrders() => remote.getOrders();

  @override
  Future<void> createOrder(Order order) {
    final model = OrderModel.fromEntity(order);
    return remote.createOrder(model);
  }

  @override
  Future<void> updateOrder(Order order) {
    final model = OrderModel.fromEntity(order);
    return remote.updateOrder(model);
  }

  @override
  Future<void> deleteOrder(int id) => remote.deleteOrder(id);

  @override
  Future<Order?> getOrderById(int id) => remote.getOrderById(id);
}
