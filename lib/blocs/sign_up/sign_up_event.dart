part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpRequired extends SignUpEvent {
  final MyUser myUser;
  final String password;

  const SignUpRequired({required this.myUser, required this.password});

  @override
  List<Object?> get props => [myUser, password];
}
