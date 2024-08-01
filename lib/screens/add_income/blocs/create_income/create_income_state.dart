part of 'create_income_cubit.dart';

sealed class CreateIncomeState extends Equatable {
  const CreateIncomeState();

  @override
  List<Object> get props => [];
}

final class CreateIncomeInitial extends CreateIncomeState {}

final class CreateIncomeSuccess extends CreateIncomeState {}

final class CreateIncomeFailure extends CreateIncomeState {
  final String message;

  const CreateIncomeFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class CreateIncomeLoading extends CreateIncomeState {}

