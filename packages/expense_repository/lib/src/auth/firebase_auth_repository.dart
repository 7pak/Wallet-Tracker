import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/src/auth/auth_repository.dart';
import 'package:expense_repository/src/models/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirebaseAuthRepository extends AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('Users');

  FirebaseAuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth??FirebaseAuth.instance;

  @override
  Stream<User?> get user =>
      _firebaseAuth.authStateChanges().map((firebaseUser) {
        return firebaseUser;
      });

  @override
  Future<void> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      debugPrint('Firebase auth $e');
      rethrow;
    }
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    try {
      //todo add the expenses
      //await userCollection.doc();
    } catch (e) {
      debugPrint('Firebase auth $e');
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password)async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: myUser.email, password: password);

      myUser = myUser.copyWith(
        userId: user.user?.uid
      );
      return myUser;
    } catch (e) {
      debugPrint('Firebase auth $e');
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
     await _firebaseAuth.signOut();
    } catch (e) {
      debugPrint('Firebase auth $e');
      rethrow;
    }
  }
}
