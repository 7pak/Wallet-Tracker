import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_tracker/config/app_colors.dart';
import 'package:wallet_tracker/screens/add_expense/blocs/get_categories/get_categories_cubit.dart';
import 'package:wallet_tracker/screens/auth/blocs/logout/logout_cubit.dart';
import 'package:wallet_tracker/screens/home/blocs/delete_all_records/delete_all_records_cubit.dart';
import 'package:wallet_tracker/screens/home/blocs/get_expenses/get_expenses_cubit.dart';
import 'package:wallet_tracker/screens/home/blocs/get_incomes/get_incomes_cubit.dart';
import 'package:wallet_tracker/screens/home/blocs/get_user/get_user_cubit.dart';

Widget homeAppBar(BuildContext context) {
  return Row(
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.tertiary,
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.primary,
                ],
                transform: const GradientRotation(pi / 4),
              ),
            ),
          ),
          const Icon(
            CupertinoIcons.person_fill,
            color: Colors.white70,
            size: 30,
          ),
        ],
      ),
      const SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome!',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          BlocBuilder<GetUserCubit, GetUserState>(
            builder: (context, state) {
              if (state is GetUserSuccess) {
                return Text(
                  state.user.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                );
              } else {
                return const Text(
                  'User',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                );
              }
            },
          ),
        ],
      ),
      const Spacer(),
      BlocListener<DeleteAllRecordsCubit, DeleteAllRecordsState>(
        listener: (context, state) {
          if (state is DeleteAllRecordsSuccess) {
            context.read<GetExpensesCubit>().getExpenses();
            context.read<GetCategoriesCubit>().getCategories();
            context.read<GetIncomesCubit>().getIncomes();
          }
        },
        child: PopupMenuButton<int>(
          onSelected: (value) async {
            if (value == 0) {
              context.read<LogoutCubit>().logout();
            } else if (value == 1) {
              _launchRecordsDialog(context, onClick: () {
                context.read<DeleteAllRecordsCubit>().deleteAllRecords();
                Navigator.pop(context);
              });
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem<int>(
              value: 0,
              child: Row(
                children: [
                  Icon(Icons.logout),
                  SizedBox(width: 10),
                  Text('Logout'),
                ],
              ),
            ),
            const PopupMenuItem<int>(
              value: 1,
              child: Row(
                children: [
                  Icon(Icons.delete),
                  SizedBox(width: 10),
                  Text('Delete All Records'),
                ],
              ),
            ),
          ],
          icon: const Icon(
            Icons.more_vert,
            size: 30,
          ),
        ),
      ),
    ],
  );
}

Future _launchRecordsDialog(BuildContext context,
    {required VoidCallback onClick}) {
  return showDialog(
      context: context,
      builder: (cxt) {
        return AlertDialog(
          title: const Text(
            'Are you sure? all records will be deleted!',
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                  color: Colors.red,
                ),
                MaterialButton(
                  onPressed: () => onClick(),
                  child: const Text("Submit"),
                  color: AppColors.primaryColor,
                )
              ],
            )
          ],
        );
      });
}
