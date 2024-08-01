import 'package:expense_repository/src/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Stream<User?> get user;

  Future<MyUser> signUp(MyUser myUser, String password);

  Future<void> setUserData(MyUser myUser);

  Future<void> login(String email, String password);

  Future<void> logout();

  Future<MyUser> getUserData();
}
