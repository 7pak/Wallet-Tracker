import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wallet_tracker/blocs/navigation/navigation_cubit.dart';
import 'package:wallet_tracker/screens/home/blocs/get_expenses/get_expenses_cubit.dart';
import 'package:wallet_tracker/screens/home/blocs/get_incomes/get_incomes_cubit.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final aDate = DateTime(date.year, date.month, date.day);

    if (aDate == today) {
      return 'Today';
    } else if (aDate == yesterday) {
      return 'Yesterday';
    } else if (aDate.year == today.year) {
      return DateFormat('d MMMM').format(date);
    } else {
      return DateFormat('d/M/yyyy').format(date);
    }
  }

  Widget _transactionItem(dynamic transaction) {
    final bool isExpense = transaction is Expense;
    final int amount = isExpense ? transaction.amount : transaction.amount;
    final String name =
        isExpense ? transaction.category.name : transaction.name;
    final int color = isExpense ? transaction.category.color : 0xFFFFFFFF;
    final String icon = isExpense ? transaction.category.icon : "income.png";

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Stack(alignment: Alignment.center, children: [
              Container(
                height: 50,
                width: 50,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Color(color)),
              ),
              Image.asset(
                'assets/images/$icon',
                color: isExpense
                    ? (Color(color).computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white)
                    : null,
                scale: 1.5,
                width: 40,
                height: 40,
              )
            ]),
            const SizedBox(
              width: 10,
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${isExpense ? '-' : '+'} \$$amount',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isExpense ? Colors.red : Colors.green),
                ),
                Text(
                  _formatDate(transaction.date),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExpensesCubit, GetExpensesState>(
      builder: (context, expensesState) {
        return BlocBuilder<GetIncomesCubit, GetIncomesState>(
          builder: (context, incomesState) {
            if (expensesState is GetExpensesSuccess &&
                incomesState is GetIncomesSuccess) {
              List<dynamic> items = [
                ...expensesState.expenses,
                ...incomesState.incomes
              ];

              items.sort((a, b) => b.date.compareTo(a.date));

              return Expanded(
                child: BlocBuilder<NavigationCubit, NavigationState>(
                    builder: (context, state) {
                  if (state.selectedIndex == 0) {
                    if (items.length > 4) {
                      items = items.sublist(0, 4);
                    }
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state.selectedIndex == 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Transactions',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            TextButton(
                                onPressed: () {
                                  context
                                      .read<NavigationCubit>()
                                      .setSelectedIndex(1);
                                },
                                child: const Text('View all',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey)))
                          ],
                        ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, int i) {
                            return _transactionItem(items[i]);
                          },
                        ),
                      )
                    ],
                  );
                }),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }
}
