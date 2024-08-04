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

      await _updateCategoryTotalExpenses(expense.category.categoryId, expense.amount);
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

  Future<void> _updateCategoryTotalExpenses(String categoryId,int newAmount)async {
    try{

      final categoryDoc = await categoryCollection.doc(categoryId).get();

      if (categoryDoc.exists) {
        final categoryData = categoryDoc.data() as Map<String, dynamic>;
        final currentTotalCategoryExpenses = categoryData['totalExpenses'] as int? ??
            0;
        final updatedTotalCategoryExpenses = currentTotalCategoryExpenses +
            newAmount;

        await categoryDoc.reference.update({
          'totalExpenses': updatedTotalCategoryExpenses,
        });
      }

    }catch(e){
      debugPrint("FirebaseError ${e.toString()}");
    }
  }


  @override
  Future<void> removeCategory(Category category) async {
    try {
      await categoryCollection.doc(category.categoryId).delete();
    } catch (e) {
      debugPrint('FirebaseError${e.toString()}');
    }
  }

  @override
  Future<void> deleteAllExpenses() async {
    try {
      final querySnapshot = await expenseCollection.get();

      WriteBatch batch = FirebaseFirestore.instance.batch();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        batch.delete(document.reference);
      }
      await batch.commit();
      await _resetAllCategoryTotalExpenses();
    } catch (e) {
      debugPrint('FirebaseError deleting documents: ${e.toString()}');
    }
  }

  Future<void> _resetAllCategoryTotalExpenses() async {
    try {

      final querySnapshot = await categoryCollection.get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.update({
          'totalExpenses': 0,
        });
      }
    } catch (e) {
      debugPrint("FirebaseError ${e.toString()}");
    }
  }
}
