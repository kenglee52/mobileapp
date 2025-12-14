import 'package:mobileapp/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.name,
    required super.age,
    required super.tel,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      age: json["age"],
      tel: json["tel"],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "name": name,
      "age": age,
      "tel": tel,
    };
  }

}
