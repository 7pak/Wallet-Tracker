import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_tracker/config/app_colors.dart';
import 'package:wallet_tracker/screens/auth/blocs/login/login_cubit.dart';
import 'package:wallet_tracker/screens/auth/widgets/custom_text_button.dart';
import 'package:wallet_tracker/screens/auth/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool securePassword = true;
  IconData iconPassword = Icons.visibility_off_outlined;
  String? errMessage;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          isLoading = false;
        } else if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginFailure) {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.message ?? 'An error occurred'),
              // Use the error message from the state if available
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: CustomTextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Email',
                  errMessage: errMessage,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill this field';
                    }
                    if (!RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                        .hasMatch(value)) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                  prefixIcon: const Icon(
                    CupertinoIcons.mail_solid,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: CustomTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  obSecureText: securePassword,
                  errMessage: errMessage,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill this field';
                    }
                    if (!RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                  prefixIcon: const Icon(
                    CupertinoIcons.lock_fill,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          securePassword = !securePassword;
                          iconPassword = securePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined;
                        });
                      },
                      icon: Icon(
                        iconPassword,
                        color: securePassword
                            ? Colors.grey
                            : AppColors.primaryColor,
                      )),
                ),
              ),
              const SizedBox(height: 30),
              !isLoading
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: customAuthTextButton('Login', () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginCubit>().login(
                              email: _emailController.text,
                              password: _passwordController.text);
                        }
                      }),
                    )
                  : const Center(child: CircularProgressIndicator())
            ],
          )),
    );
  }
}
