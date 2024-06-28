import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_tracker/blocs/authentication/authentication_bloc.dart';
import 'package:wallet_tracker/blocs/login/login_bloc.dart';
import 'package:wallet_tracker/screens/auth/views/auth_screen.dart';
import 'package:wallet_tracker/screens/home/blocs/get_expenses/get_expenses_bloc.dart';
import 'package:wallet_tracker/screens/home/views/home_screen.dart';

import 'config/app_colors.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense data',
        theme: ThemeData(
            colorScheme: ColorScheme.light(
                background: Colors.grey[200]!,
                onBackground: Colors.black,
                primary: AppColors.primaryColor,
                secondary: AppColors.secondaryColor,
                tertiary: AppColors.tertiary,
                outline: AppColors.outline)),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                    GetExpensesBloc(FirebaseExpenseRepo())
                      ..add(GetExpenses()),
                  ),
                  BlocProvider(
                    create: (context) => LoginBloc(authRepository: context.read<AuthenticationBloc>().authRepository),
                  ),
                ],
                child: const HomeScreen(),
              );
            } else {
              return const AuthScreen();
            }
          },
        )
    );
  }
}
