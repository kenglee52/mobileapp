import 'package:flutter/material.dart';
import 'package:mobileapp/domain/entities/user.dart';
import 'package:mobileapp/domain/usecases/user/create_user.dart';
import 'package:mobileapp/domain/usecases/user/delete_user.dart';
import 'package:mobileapp/domain/usecases/user/get_users.dart';
import 'package:mobileapp/domain/usecases/user/update_user.dart';

class UserViewModel extends ChangeNotifier {
  final GetUsers getUsersUsecase;
  final CreateUser createUserUsecase;
  final UpdateUser updateUserUseCase;
  final DeleteUser deleteUserUsecase;
  UserViewModel({
    required this.getUsersUsecase,
    required this.createUserUsecase,
    required this.updateUserUseCase,
    required this.deleteUserUsecase,
  });

  List<User> users = [];
  bool isLoading = true;

  Future<void> LoadUsers() async {
    isLoading = true;
    notifyListeners();
    users = await getUsersUsecase();
    isLoading = false;
    notifyListeners();
  }

  Future<void> addUser(User user) async {
    await createUserUsecase(user);
    await LoadUsers();
  }

  Future<void> editUser(User user) async {
    await updateUserUseCase(user);
    await LoadUsers();
  }

  Future<void> removeUser(int id) async {
    await deleteUserUsecase(id);
    await LoadUsers();
  }
}
