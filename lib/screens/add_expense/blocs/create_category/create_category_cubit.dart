import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';

part 'create_category_state.dart';

class CreateCategoryCubit extends Cubit<CreateCategoryState> {
  final ExpenseRepository expenseRepository;
  CreateCategoryCubit(this.expenseRepository) : super(CreateCategoryInitial());

  Future<void> createCategory(Category category) async {
    emit(CreateCategoryLoading());
    try{
      await expenseRepository.createCategory(category);
      emit(CreateCategorySuccess());
    }catch(e){
      emit( CreateCategoryFailure(e.toString()));
    }
  }
}
