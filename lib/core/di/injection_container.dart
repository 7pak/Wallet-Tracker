import 'package:expense_repository/expense_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:wallet_tracker/blocs/authentication/authentication_cubit.dart';
import 'package:wallet_tracker/screens/auth/blocs/login/login_cubit.dart';
import 'package:wallet_tracker/screens/auth/blocs/logout/logout_cubit.dart';
import 'package:wallet_tracker/screens/auth/blocs/sign_up/sign_up_cubit.dart';
import 'package:wallet_tracker/screens/home/blocs/get_user/get_user_cubit.dart';

final locator = GetIt.instance;

void setupDependencies(){
  locator.registerSingleton<AuthRepository>(FirebaseAuthRepository());

  locator.registerFactory<ExpenseRepository>(()=>FirebaseExpenseRepo());

  locator.registerFactory<IncomeRepository>(()=>FirebaseIncomeRepo());

  locator.registerFactory(()=> AuthenticationCubit(authRepository: locator()));
  locator.registerLazySingleton(()=> GetUserCubit(authRepository: locator()));

  locator.registerLazySingleton(()=> LoginCubit(authRepository: locator()));
  locator.registerLazySingleton(()=> SignUpCubit(authRepository: locator()));
  locator.registerLazySingleton(()=> LogoutCubit(authRepository: locator()));

}