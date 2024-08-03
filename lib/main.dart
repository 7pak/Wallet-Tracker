import 'package:bloc/bloc.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:wallet_tracker/simple_bloc_observer.dart';
import 'app.dart';
import 'config/app_colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor:  AppColors.background,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(  MyApp(FirebaseAuthRepository()));
}

