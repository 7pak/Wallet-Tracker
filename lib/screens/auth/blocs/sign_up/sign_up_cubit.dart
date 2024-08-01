import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {

  final AuthRepository _authRepository;

  SignUpCubit({required AuthRepository authRepository}) :_authRepository = authRepository, super(SignUpInitial());

  Future<void> signUp({required MyUser myUser,required String password})async {
    emit(SignUpLoading());
    try {
      MyUser user = await _authRepository.signUp(myUser,password);
      await _authRepository.setUserData(user);
      if (!isClosed) emit(SignUpSuccess());
    } catch (e) {
      if (!isClosed) emit(SignUpFailure(message: e.toString()));
    }
  }
}
