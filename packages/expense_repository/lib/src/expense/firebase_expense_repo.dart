import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirebaseExpenseRepo extends ExpenseRepository {
  final CollectionReference categoryCollection;
  final CollectionReference expenseCollection;

  FirebaseExpenseRepo()
      :categoryCollection = FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser?.uid ?? '')
            .collection('Categories'),
        expenseCollection = FirebaseFirestore.instance.collection('Users')
      .doc(FirebaseAuth.instance.currentUser?.uid ?? '').collection('Expenses');

  @override
  Future<void> createCategory(Category category) async {
    try {
      await categoryCollection
          .doc(category.categoryId)
          .set(category.toEntity().toDocument());
    } catch (e) {
      log('FirebaseError ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    try {
      return await categoryCollection.get().then((value) => value.docs
          .map((e) => Category.fromEntity(
              CategoryEntity.fromDocument(e.data() as Map<String, dynamic>)))
          .toList());
    } catch (e) {
      debugPrint('FirebaseError ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> createExpense(Expense expense) async {
    try {
      await expenseCollection
          .doc(expense.expenseId)
          .set(expense.toEntity().toDocument());
    } catch (e) {
      log('FirebaseError ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<List<Expense>> getExpenses() async {
    try {
      return await expenseCollection.get().then((value) => value.docs
          .map((e) => Expense.fromEntity(
              ExpenseEntity.fromDocument(e.data() as Map<String, dynamic>)))
          .toList());
    } catch (e) {
      debugPrint('FirebaseError ${e.toString()}');
      rethrow;
    }
  }
}
