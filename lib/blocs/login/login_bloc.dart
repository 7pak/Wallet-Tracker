import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginInitial()) {
    on<LoginRequired>((event, emit) async{
      emit(LoginLoading());
     try{
       await _authRepository.login(event.email, event.password);
     }catch (e){
       emit(LoginFailure(message: e.toString()));
     }
    });
    on<Logout>((event, emit) async{
      emit(LogoutLoading());
      try{
        await _authRepository.logout();
      }on FirebaseAuthException catch(e){
        emit(LogoutFailure(message: e.toString()));
      }
      catch (e){
        emit(LogoutFailure(message: e.toString()));
      }
    });
  }
}
