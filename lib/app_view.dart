import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_tracker/blocs/authentication/authentication_cubit.dart';
import 'package:wallet_tracker/screens/auth/blocs/login/login_cubit.dart';
import 'package:wallet_tracker/screens/auth/views/auth_screen.dart';
import 'package:wallet_tracker/screens/home/blocs/get_expenses/get_expenses_cubit.dart';
import 'package:wallet_tracker/screens/home/blocs/get_user/get_user_cubit.dart';
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
        home: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            if (state.status == CurrentUserStatus.authenticated) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                    GetExpensesCubit(FirebaseExpenseRepo())
                      ..getExpenses(),
                  ),
                  BlocProvider(
                    create: (context) => LoginCubit(authRepository: context.read<AuthenticationCubit>().authRepository),
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
