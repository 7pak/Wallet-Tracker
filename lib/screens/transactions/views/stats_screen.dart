import 'package:flutter/material.dart';
import 'package:wallet_tracker/screens/common_widgets/transactions_list_widget.dart';
import 'package:wallet_tracker/screens/transactions/widgets/pie_chart.dart';


class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Transactions',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(16),
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
              ),
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.width) * 0.5,
              child: const PieChartStat(),
            ),
            const SizedBox(height: 12,),
            const TransactionsList()
          ],
        ),
      ),
    );
  }
}
