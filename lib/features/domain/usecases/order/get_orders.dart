import 'package:mobileapp/features/domain/entities/order.dart';
import 'package:mobileapp/features/domain/repositories/order_repository.dart';

class GetOrders {
  final OrderRepository repository;
  GetOrders(this.repository);
  Future<List<Order>> call() {
    return repository.getOrders();
  }
}
