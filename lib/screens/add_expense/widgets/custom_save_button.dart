import 'package:flutter/material.dart';

Widget customSaveTextButton(
    {String text = 'Save', required void Function() save}) {
  return TextButton(
    onPressed: () {
      save();
    },
    style: TextButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    child: Text(
      text,
      style: const TextStyle(fontSize: 20, color: Colors.white),
    ),
  );
}
