part of 'get_incomes_cubit.dart';

sealed class GetIncomesState extends Equatable {
  const GetIncomesState();

  @override
  List<Object> get props => [];
}

final class GetIncomesInitial extends GetIncomesState {}

final class GetIncomesFailure extends GetIncomesState {
  final String message;

  const GetIncomesFailure(this.message);
}

final class GetIncomesLoading extends GetIncomesState {}

final class GetIncomesSuccess extends GetIncomesState {
  final List<Income> incomes;

  const GetIncomesSuccess(this.incomes);

  @override

  List<Object> get props => [incomes];

}
