import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_tracker/config/app_colors.dart';
import 'package:wallet_tracker/screens/add_income/blocs/create_income/create_income_cubit.dart';
import 'package:wallet_tracker/screens/add_income/views/add_income.dart';
import 'package:wallet_tracker/screens/home/blocs/get_incomes/get_incomes_cubit.dart';

import '../../add_expense/blocs/create_category/create_category_cubit.dart';
import '../../add_expense/blocs/create_expense/create_expense_cubit.dart';
import '../../add_expense/blocs/get_categories/get_categories_cubit.dart';
import '../../add_expense/views/add_expense.dart';
import '../blocs/get_expenses/get_expenses_cubit.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB(
      {super.key,
      required this.isExpanded,
      required this.toggleExpanded,
      required this.animation});

  final bool isExpanded;
  final Animation<double> animation;
  final VoidCallback toggleExpanded;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isExpanded)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text(
                    'income',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  FloatingActionButton(
                    backgroundColor: AppColors.secondaryColor,
                    onPressed: () {
                      toggleExpanded();
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute<bool>(
                          builder: (BuildContext context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                  create: (context) =>
                                      CreateIncomeCubit(FirebaseIncomeRepo()))
                            ],
                            child: const AddIncome(),
                          ),
                        ),
                      )
                          .then((result) {
                        if (result == true) {
                          context.read<GetIncomesCubit>().getIncomes();
                        }
                      });
                    },
                    mini: true,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  const Text('Expense',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  FloatingActionButton(
                    backgroundColor: AppColors.secondaryColor,
                    onPressed: () {
                      toggleExpanded();
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute<bool>(
                          builder: (BuildContext context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) =>
                                    CreateCategoryCubit(FirebaseExpenseRepo()),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    GetCategoriesCubit(FirebaseExpenseRepo())
                                      ..getCategories(),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    CreateExpenseCubit(FirebaseExpenseRepo()),
                              ),
                            ],
                            child: const AddExpense(),
                          ),
                        ),
                      )
                          .then((result) {
                        if (result == true) {
                          context.read<GetExpensesCubit>().getExpenses();
                        }
                      });
                    },
                    mini: true,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            onPressed: toggleExpanded,
            shape: const CircleBorder(),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.tertiary,
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.primary,
                ], transform: const GradientRotation(pi / 4)),
              ),
              child: Center(
                child: AnimatedIcon(
                  icon: AnimatedIcons.add_event,
                  progress: animation,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
