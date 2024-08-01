import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';

part 'get_expenses_state.dart';

class GetExpensesCubit extends Cubit<GetExpensesState> {
  final ExpenseRepository expenseRepository;

  GetExpensesCubit(this.expenseRepository) : super(GetExpensesInitial());

  Future<void> getExpenses()async{

    emit(GetExpensesLoading());
    try{
      List<Expense> expenses = await expenseRepository.getExpenses();
      emit(GetExpensesSuccess(expenses));
    }catch (e){
      emit(GetExpensesFailure(e.toString()));
    }
  }
}
