import 'package:hive/hive.dart';
part 'account_model.g.dart';

@HiveType(typeId: 1)
class UserAccountModel {
  UserAccountModel({required this.username, required this.password});

  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  @override
  String toString() {
    return 'UserAccountModel{username: $username, password: $password}';
  }
}