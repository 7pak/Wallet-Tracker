import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LogoutCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      _authRepository.logout();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutFailure(message: e.toString()));
    }
  }
}
