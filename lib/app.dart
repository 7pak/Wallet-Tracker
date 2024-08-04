import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_tracker/blocs/authentication/authentication_cubit.dart';
import 'package:wallet_tracker/core/di/injection_container.dart';
import 'app_view.dart';

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => locator<AuthenticationCubit>(),
      child: const MyAppView(),
    );
  }
}
