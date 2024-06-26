
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';

class FirebaseExpenseRepo extends ExpenseRepository{
  final categoryCollection = FirebaseFirestore.instance.collection('Categories');
  final expenseCollection = FirebaseFirestore.instance.collection('Expenses');
  @override
  Future<void> createCategory(Category category) async {
    try{
     await  categoryCollection.doc(category.categoryId).set(category.toEntity().toDocument());
    }catch(e){
      log('FirebaseError ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<List<Category>> getCategories()async {
    try{
      return await  categoryCollection
      .get().then((value) => value.docs.map((e)=>Category.fromEntity(CategoryEntity.fromDocument(e.data()))).toList());
    }catch(e){
      log('FirebaseError ${e.toString()}');
      rethrow;
    }
  }


}