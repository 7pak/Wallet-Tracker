import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    try {
      _authRepository.login(email, password);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(message: e.toString()));
    }
  }
}
