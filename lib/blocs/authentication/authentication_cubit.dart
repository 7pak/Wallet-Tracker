import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthRepository _authRepository;
  late final StreamSubscription<User?> _userSubscription;

  AuthenticationCubit({required AuthRepository authRepository})
      : _authRepository = authRepository, super(const AuthenticationState.unknown()){
    _userSubscription = _authRepository.user.listen((user){
      if (user != null) {
        emit(AuthenticationState.authenticated(user));
      } else {
        emit(const AuthenticationState.unauthenticated());
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

}
