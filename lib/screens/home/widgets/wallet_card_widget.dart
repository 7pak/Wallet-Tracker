import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget _walletDetails(IconData icon,Color iconColor, String title, String detail) {
  return Row(children: [
     Icon(icon, color: iconColor, size: 30),
    const SizedBox(
      width: 6,
    ),
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title,
        style: TextStyle(color: Colors.grey[200]!, fontWeight: FontWeight.w400),
      ),
       Text('\$ $detail',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
    ])
  ]);
}

class WalletCard extends StatelessWidget {
  const WalletCard({super.key});

  @override
  Widget build(BuildContext context) {
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
          const Text('\$ 5300.00',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Row(children: [
              _walletDetails(FontAwesomeIcons.arrowUpLong,Colors.green, 'Income', '3200.00'),
              const Spacer(),
              _walletDetails(FontAwesomeIcons.arrowDownLong,Colors.red, 'Expenses', '1050.00')
            ]),
          )
        ],
      ),
    );
  }
}

