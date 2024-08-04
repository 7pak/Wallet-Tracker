import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';

part 'remove_category_state.dart';

class RemoveCategoryCubit extends Cubit<RemoveCategoryState> {
  final ExpenseRepository expenseRepository;
  RemoveCategoryCubit(this.expenseRepository) : super(RemoveCategoryInitial());

  Future<void> removeCategory(Category category)async{
    emit(RemoveCategoryLoading());
    try{
      await expenseRepository.removeCategory(category);
      emit(RemoveCategorySuccess());
    }catch (e){
      emit(RemoveCategoryFailure(message: e.toString()));
    }
  }

}
