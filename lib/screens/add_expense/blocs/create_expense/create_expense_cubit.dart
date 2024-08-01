import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';

part 'create_expense_state.dart';

class CreateExpenseCubit extends Cubit<CreateExpenseState> {
  final ExpenseRepository expenseRepository;
  CreateExpenseCubit(this.expenseRepository) : super(CreateExpenseInitial());

  Future<void> createExpense(Expense expense) async {
    emit(CreateExpenseLoading());

    try {
      await expenseRepository.createExpense(expense);
      emit(CreateExpenseSuccess());
    } catch (e) {
      emit(CreateExpenseFailure(e.toString()));
    }
  }
}
