import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  final AuthRepository _authRepository;

  GetUserCubit({required AuthRepository authRepository}) : _authRepository = authRepository, super(GetUserInitial());

  Future<void> getUser() async{
    emit(GetUserLoading());
    try{
      MyUser user = await _authRepository.getUserData();
      emit(GetUserSuccess(user: user));
    }catch (e){
      emit(GetUserFailure(message: e.toString()));
    }
  }
}
