import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_tracker/screens/add_income/blocs/create_income/create_income_cubit.dart';
import 'package:wallet_tracker/screens/add_income/views/add_income.dart';

import '../../add_expense/blocs/create_category/create_category_cubit.dart';
import '../../add_expense/blocs/create_expense/create_expense_cubit.dart';
import '../../add_expense/blocs/get_categories/get_categories_cubit.dart';
import '../../add_expense/views/add_expense.dart';
import '../blocs/get_expenses/get_expenses_cubit.dart';

class CustomFABWithPopoutButtons extends StatefulWidget {
  const CustomFABWithPopoutButtons({super.key});

  @override
  State<CustomFABWithPopoutButtons> createState() =>
      _CustomFABWithPopoutButtonsState();
}

class _CustomFABWithPopoutButtonsState extends State<CustomFABWithPopoutButtons>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleButtons() {
    if (_isExpanded) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_isExpanded)
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
                    onPressed: () {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute<bool>(
                          builder: (BuildContext context) => MultiBlocProvider(
                           providers: [
                             BlocProvider(create: (context)=>CreateIncomeCubit(FirebaseIncomeRepo()))
                           ],
                      child: const AddIncome(),
                          ),
                        ),
                      )
                          .then((result) {
                        if (result == true) {
                         // context.read<GetExpensesCubit>().getExpenses();
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
                    onPressed: () {
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
            onPressed: _toggleButtons,
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
                  progress: _animation,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
