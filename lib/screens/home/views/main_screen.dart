
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/home_app_bar_widget.dart';
import '../../common_widgets/transactions_list_widget.dart';
import '../widgets/wallet_card_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          children: [
             homeAppBar(context),
            const SizedBox(
              height: 20,
            ),
            const WalletCard(),
            const SizedBox(
              height: 20,
            ),
             const TransactionsList()
          ],
        ),
      ),
    );
  }
}
