import 'package:mobileapp/domain/entities/user.dart';
import 'package:mobileapp/domain/respositories/user_repository.dart';

class GetUsers {
  final UserRepository respository;
  GetUsers(this.respository);
  Future<List<User>> call() {
    return respository.getUsers();
  }
}