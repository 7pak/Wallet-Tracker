import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wallet_tracker/screens/home/blocs/get_expenses/get_expenses_cubit.dart';
import 'package:wallet_tracker/screens/home/blocs/get_incomes/get_incomes_cubit.dart';

Widget _walletDetails(
    IconData icon, Color iconColor, String title, String detail) {
  return Row(children: [
    Icon(icon, color: iconColor, size: 30),
    const SizedBox(
      width: 6,
    ),
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        style: TextStyle(color: Colors.grey[200]!, fontWeight: FontWeight.w400),
      ),
      Text('\$ $detail',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600)),
    ])
  ]);
}

class WalletCard extends StatelessWidget {
  const WalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var expenses = context.select((GetExpensesCubit bloc) => bloc.state);
      var incomes = context.select((GetIncomesCubit bloc) => bloc.state);
      int totalExpense = 0;
      int totalIncome = 0;
      DateTime today = DateTime.now();

      if (expenses is GetExpensesSuccess) {
        if (expenses.expenses.isNotEmpty) {
          totalExpense = expenses.expenses
              .where((element) =>
                  element.date.isBefore(today) ||
                  element.date.isAtSameMomentAs(today))
              .map((element) => element.amount)
              .reduce((a, b) => a + b);
        }
      }

      if (incomes is GetIncomesSuccess) {
        if (incomes.incomes.isNotEmpty) {
          totalIncome = incomes.incomes
              .where((element) =>
                  element.date.isBefore(today) ||
                  element.date.isAtSameMomentAs(today))
              .map((element) => element.amount)
              .reduce((a, b) => a + b);
        }
      }

      int totalBalance;
      try {
        totalBalance = totalIncome - totalExpense;
      } catch (e) {
        totalBalance = 0;
      }
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.tertiary,
            ], transform: const GradientRotation(pi / 4)),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  color: Colors.grey[400]!,
                  offset: const Offset(5, 5))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total Balance',
                style: TextStyle(
                    color: Colors.grey[200]!,
                    fontSize: 15,
                    fontWeight: FontWeight.w400)),
            const SizedBox(height: 8),
            Text('\$ $totalBalance.00',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold)),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Row(children: [
                _walletDetails(FontAwesomeIcons.arrowUpLong, Colors.green,
                    'Income', '$totalIncome.00'),
                const Spacer(),
                _walletDetails(FontAwesomeIcons.arrowDownLong, Colors.red,
                    'Expenses', '$totalExpense.00')
              ]),
            )
          ],
        ),
      );
    });
  }
}
