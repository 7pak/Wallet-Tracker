import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_tracker/config/app_colors.dart';

Widget customAuthTextButton(String text, VoidCallback onPress) {
  return TextButton(
      onPressed: onPress,
      style: TextButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
          elevation: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ));
}
