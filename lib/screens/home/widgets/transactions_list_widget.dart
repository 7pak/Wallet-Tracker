import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wallet_tracker/screens/home/blocs/get_expenses/get_expenses_cubit.dart';

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

  Widget _transactionItem(Expense expense) {
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
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(expense.category.color)),
              ),
              Image.asset(
                'assets/images/${expense.category.icon}',
                color: Color(expense.category.color).computeLuminance() > 0.5
                    ? Colors.black
                    : Colors.white,
                scale: 1.5,
              )
            ]),
            const SizedBox(
              width: 10,
            ),
            Text(
              expense.category.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '-\$${expense.amount}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  _formatDate(expense.date),
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
        builder: (context, state) {
      if (state is GetExpensesSuccess) {
        return Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Transactions',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(
                      onPressed: () {},
                      child: const Text('View all',
                          style: TextStyle(fontSize: 14, color: Colors.grey)))
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: state.expenses.length,
                    itemBuilder: (context, int i) {
                      List<Expense> expenses = state.expenses.reversed.toList();
                      return _transactionItem(expenses[i]);
                    }),
              )
            ],
          ),
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
