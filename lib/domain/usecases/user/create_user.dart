import 'package:mobileapp/domain/entities/user.dart';
import 'package:mobileapp/domain/respositories/user_repository.dart';

class CreateUser {
  final UserRepository respository;
  CreateUser(this.respository);
  Future<void> call(User user) {
    return respository.createUser(user);
  }
}