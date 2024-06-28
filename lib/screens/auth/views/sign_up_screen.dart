import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_tracker/screens/auth/widgets/custom_text_button.dart';
import 'package:wallet_tracker/screens/auth/widgets/password_detector.dart';

import '../../../blocs/sign_up/sign_up_bloc.dart';
import '../widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool securePassword = true;
  IconData iconPassword = Icons.visibility_off_outlined;
  bool isLoading = false;

  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
  listener: (context, state) {
    if(state is SignUpSuccess){
      isLoading = false;
    }else if(state is SignUpLoading){
      isLoading = true;
    }else if(state is SignUpFailure){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message ?? 'An error occurred'), // Use the error message from the state if available
          duration: const Duration(seconds: 3),
        ),
      );
    }
  },
  child: Form(
      key: _formKey,
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: CustomTextField(
                  controller: _nameController,
                  hintText: 'Name',
                  obSecureText: false,
                  keyboardType: TextInputType.name,
                  prefixIcon: const Icon(CupertinoIcons.person_fill),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please fill in this field';
                    } else if (val.length > 30) {
                      return 'Name too long';
                    }
                    return null;
                  }),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: CustomTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  obSecureText: false,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(CupertinoIcons.mail_solid),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please fill in this field';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                        .hasMatch(val)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  }),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: CustomTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obSecureText: securePassword,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(CupertinoIcons.lock_fill),
                  onChanged: (val) {
                    if (val!.contains(RegExp(r'[A-Z]'))) {
                      setState(() {
                        containsUpperCase = true;
                      });
                    } else {
                      setState(() {
                        containsUpperCase = false;
                      });
                    }
                    if (val.contains(RegExp(r'[a-z]'))) {
                      setState(() {
                        containsLowerCase = true;
                      });
                    } else {
                      setState(() {
                        containsLowerCase = false;
                      });
                    }
                    if (val.contains(RegExp(r'[0-9]'))) {
                      setState(() {
                        containsNumber = true;
                      });
                    } else {
                      setState(() {
                        containsNumber = false;
                      });
                    }
                    if (val.contains(RegExp(
                        r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
                      setState(() {
                        containsSpecialChar = true;
                      });
                    } else {
                      setState(() {
                        containsSpecialChar = false;
                      });
                    }
                    if (val.length >= 8) {
                      setState(() {
                        contains8Length = true;
                      });
                    } else {
                      setState(() {
                        contains8Length = false;
                      });
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        securePassword = !securePassword;
                        if (securePassword) {
                          iconPassword = Icons.visibility_off_outlined;
                        } else {
                          iconPassword = Icons.visibility_outlined;
                        }
                      });
                    },
                    icon: Icon(iconPassword),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please fill in this field';
                    } else if (!RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                        .hasMatch(val)) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  }),
            ),
            const SizedBox(height: 10),
            passwordDetector(context, containsUpperCase, containsLowerCase,
                containsNumber, containsSpecialChar, contains8Length),
            const SizedBox(height: 10),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            !isLoading
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: customAuthTextButton('Sign up', () {
                      if (_formKey.currentState!.validate()) {
                        MyUser myUser = MyUser.empty;
                        myUser = myUser.copyWith(
                          email: _emailController.text,
                          name: _nameController.text,
                        );
                        setState(() {
                          context.read<SignUpBloc>().add(SignUpRequired(
                              myUser: myUser,
                              password: _passwordController.text));
                        });
                      }
                    }))
                : const Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    ),
);
  }
}
