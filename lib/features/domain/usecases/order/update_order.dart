import 'package:mobileapp/features/domain/entities/order.dart';
import 'package:mobileapp/features/domain/repositories/order_repository.dart';

class UpdateOrder {
  final OrderRepository repository;
  UpdateOrder(this.repository);
  Future<void> call(Order order) {
    return repository.updateOrder(order);
  }
}
