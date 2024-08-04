part of 'logout_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

final class LogoutInitial extends LoginState {}
final class LogoutSuccess extends LoginState {}
final class LogoutLoading extends LoginState {}
final class LogoutFailure extends LoginState {
  final String? message;

  const LogoutFailure({required this.message});

}


