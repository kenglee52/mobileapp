import 'package:mobileapp/features/domain/entities/order.dart';
import 'package:mobileapp/features/domain/repositories/order_repository.dart';

class GetOrderById {
  final OrderRepository repository;
  GetOrderById(this.repository);
  Future<Order?> call(int id) {
    return repository.getOrderById(id);
  }
}
