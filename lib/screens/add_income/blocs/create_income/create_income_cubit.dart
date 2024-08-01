import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';

part 'create_income_state.dart';

class CreateIncomeCubit extends Cubit<CreateIncomeState> {
  final IncomeRepository incomeRepository;
  CreateIncomeCubit(this.incomeRepository) : super(CreateIncomeInitial());

  Future<void> createIncome(Income income) async {
    emit(CreateIncomeLoading());

    try {
      await incomeRepository.createIncome(income);
      emit(CreateIncomeSuccess());
    } catch (e) {
      emit(CreateIncomeFailure(e.toString()));
    }
  }
}
