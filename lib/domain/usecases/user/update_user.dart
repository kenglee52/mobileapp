import 'package:mobileapp/domain/entities/user.dart';
import 'package:mobileapp/domain/respositories/user_repository.dart';

class UpdateUser {
  final UserRepository repository;
  UpdateUser(this.repository);
  Future<void> call(User user) {
    return repository.updateUser(user);
  }
}
