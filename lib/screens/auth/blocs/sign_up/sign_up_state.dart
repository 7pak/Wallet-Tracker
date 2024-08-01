part of 'sign_up_cubit.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class SignUpSuccess extends SignUpState {}

final class SignUpFailure extends SignUpState {
  final String? message;

  const SignUpFailure({required this.message});
}

final class SignUpLoading extends SignUpState {}


