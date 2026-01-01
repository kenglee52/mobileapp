import 'package:mobileapp/features/domain/entities/order.dart';
import 'package:mobileapp/features/domain/repositories/order_repository.dart';

class CreateOrder {
  final OrderRepository repository;
  CreateOrder(this.repository);
  Future<void> call(Order order) {
    return repository.createOrder(order);
  }
}
