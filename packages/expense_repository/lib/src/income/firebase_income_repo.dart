import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class FirebaseIncomeRepo extends IncomeRepository {
  final CollectionReference incomesCollection;

  FirebaseIncomeRepo()
      : incomesCollection = FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser?.uid ?? '')
            .collection('Incomes');

  @override
  Future<void> createIncome(Income income) async {
    try {
      await incomesCollection
          .doc(income.incomeId)
          .set(income.toEntity().toDocument());
    } catch (e) {
      log('FirebaseError ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<List<Income>> getIncomes() async {
    try {
      return await incomesCollection.get().then((value) => value.docs
          .map((e) => Income.fromEntity(
              IncomeEntity.fromDocument(e.data() as Map<String, dynamic>)))
          .toList());
    } catch (e) {
      debugPrint('FirebaseError ${e.toString()}');
      rethrow;
    }
  }
}
