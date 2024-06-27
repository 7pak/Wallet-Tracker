import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:meta/meta.dart';

part 'get_categories_event.dart';
part 'get_categories_state.dart';

class GetCategoriesBloc extends Bloc<GetCategoriesEvent, GetCategoriesState> {
  final ExpenseRepository expenseRepository;
  GetCategoriesBloc(this.expenseRepository) : super(GetCategoriesInitial()) {
    on<GetCategories>((event, emit) async{
      emit(GetCategoriesLoading());
      try{
        List<Category> categories = await expenseRepository.getCategories();
        emit(GetCategoriesSuccess(categories));
      }catch (e){
        emit(GetCategoriesFailure(e.toString()));
      }
    });
  }
}
