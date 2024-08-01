import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_tracker/blocs/authentication/authentication_cubit.dart';
import 'app_view.dart';

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MyApp(this.authRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationCubit(authRepository: authRepository),
      child: const MyAppView(),
    );
  }
}
