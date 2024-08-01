import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';

part 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  final ExpenseRepository expenseRepository;
  GetCategoriesCubit(this.expenseRepository) : super(GetCategoriesInitial());

  Future<void> getCategories() async{
    emit(GetCategoriesLoading());
    try{
      List<Category> categories = await expenseRepository.getCategories();
      emit(GetCategoriesSuccess(categories));
    }catch (e){
      emit(GetCategoriesFailure(e.toString()));
    }
  }
}
