import 'package:mobileapp/data/datasources/user_remote_datasource.dart';
import 'package:mobileapp/data/models/user_model.dart';
import 'package:mobileapp/domain/entities/user.dart';
import 'package:mobileapp/domain/respositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource remote;
  UserRepositoryImpl(this.remote);

  @override
  Future<List<User>> getUsers() => remote.getUsers();

  @override
  Future<void> createUser(User user) {
    return remote.createUser(user as UserModel);
  }

  @override
  Future<void> updateUser(User user) {
    return remote.updateUser(user as UserModel);
  }

  @override
  Future<void> deleteUser(int id) => remote.deleteUser(id);
}
