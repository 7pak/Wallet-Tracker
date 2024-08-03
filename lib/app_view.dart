import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_tracker/blocs/authentication/authentication_cubit.dart';
import 'package:wallet_tracker/blocs/navigation/navigation_cubit.dart';
import 'package:wallet_tracker/config/app_theme.dart';
import 'package:wallet_tracker/screens/auth/views/auth_screen.dart';
import 'package:wallet_tracker/screens/home/blocs/get_expenses/get_expenses_cubit.dart';
import 'package:wallet_tracker/screens/home/blocs/get_incomes/get_incomes_cubit.dart';
import 'package:wallet_tracker/screens/home/blocs/get_user/get_user_cubit.dart';
import 'package:wallet_tracker/screens/home/views/home_screen.dart';


class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense data',
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        home: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            if (state.status == CurrentUserStatus.authenticated) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context)=> NavigationCubit()),
                  BlocProvider(
                    create: (context) =>
                    GetExpensesCubit(FirebaseExpenseRepo())
                      ..getExpenses(),
                  ),
                  BlocProvider(
                    create: (context) =>
                    GetIncomesCubit(FirebaseIncomeRepo())
                      ..getIncomes(),
                  ),
                  BlocProvider(
                    create: (context) => GetUserCubit(
                        authRepository:
                        context.read<AuthenticationCubit>().authRepository)..getUser(),
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
