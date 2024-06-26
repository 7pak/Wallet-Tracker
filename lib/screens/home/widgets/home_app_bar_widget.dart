import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget homeAppBar(BuildContext context){
  return Row(
    children: [
      Stack(alignment: Alignment.center, children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.yellow[700]!),
        ),
        Icon(
          CupertinoIcons.person_fill,
          color: Colors.yellow[800]!,
          size: 30,
        )
      ]),
      const SizedBox(
        width: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome!',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Theme.of(context).colorScheme.outline),
          ),
          Text(
            'Abood banne',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).colorScheme.onBackground),
          )
        ],
      ),
      const Spacer(),
      IconButton(
          onPressed: () {},
          icon: const Icon(
            CupertinoIcons.settings,
            size: 30,
          )),
    ],
  );
}