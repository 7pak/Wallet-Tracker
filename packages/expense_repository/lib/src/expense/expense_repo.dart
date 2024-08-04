import 'package:expense_repository/expense_repository.dart';

abstract class ExpenseRepository{
  Future<void> createCategory(Category category);
  Future<void> removeCategory(Category category);
  Future<List<Category>> getCategories();

  Future<void> createExpense(Expense expense);
  Future<List<Expense>> getExpenses();

  Future<void> deleteAllExpenses();


}