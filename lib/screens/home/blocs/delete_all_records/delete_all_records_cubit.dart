import 'package:bloc/bloc.dart';
import 'package:expense_repository/expense_repository.dart';

part 'delete_all_records_state.dart';

class DeleteAllRecordsCubit extends Cubit<DeleteAllRecordsState> {
  final ExpenseRepository expenseRepository;
  final IncomeRepository incomeRepository;
  DeleteAllRecordsCubit(this.expenseRepository, this.incomeRepository) : super(DeleteAllRecordsInitial());

  Future<void> deleteAllRecords()async{
    emit(DeleteAllRecordsLoading());
    try{
      await expenseRepository.deleteAllExpenses();
      await incomeRepository.deleteAllIncomes();

      emit(DeleteAllRecordsSuccess());
    }catch(e){
      emit(DeleteAllRecordsFailure(message: e.toString()));
    }
  }
}
