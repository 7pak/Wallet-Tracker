part of 'get_expenses_cubit.dart';

sealed class GetExpensesState extends Equatable {
  const GetExpensesState();

  @override
  List<Object> get props => [];
}

final class GetExpensesInitial extends GetExpensesState {}

final class GetExpensesFailure extends GetExpensesState {
  final String message;

  const GetExpensesFailure(this.message);
}

final class GetExpensesLoading extends GetExpensesState {}

final class GetExpensesSuccess extends GetExpensesState {
  final List<Expense> expenses;

  const GetExpensesSuccess(this.expenses);

  @override

  List<Object> get props => [expenses];

}
