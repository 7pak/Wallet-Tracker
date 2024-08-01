import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';

part 'get_incomes_state.dart';

class GetIncomesCubit extends Cubit<GetIncomesState> {
  final IncomeRepository incomeRepository;

  GetIncomesCubit(this.incomeRepository) : super(GetIncomesInitial());

  Future<void> getIncomes() async {
    emit(GetIncomesLoading());
    try {
      List<Income> incomes = await incomeRepository.getIncomes();
      emit(GetIncomesSuccess(incomes));
    } catch (e) {
      emit(GetIncomesFailure(e.toString()));
    }
  }
}
