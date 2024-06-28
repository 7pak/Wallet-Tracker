part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}
final class LoginSuccess extends LoginState {}
final class LoginLoading extends LoginState {}
final class LoginFailure extends LoginState {
  final String? message;

  const LoginFailure({required this.message});

}

final class LogoutSuccess extends LoginState {}
final class LogoutLoading extends LoginState {}
final class LogoutFailure extends LoginState {
  final String? message;

  const LogoutFailure({required this.message});

}
