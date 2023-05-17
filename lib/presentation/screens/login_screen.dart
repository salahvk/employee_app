// ignore_for_file: use_build_context_synchronously

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:employee_app/config/route_manager.dart';
import 'package:employee_app/data/repositories/user_login.dart';
import 'package:employee_app/utils/animated_snackbar.dart';
import 'package:employee_app/utils/color_manager.dart';
import 'package:employee_app/utils/style_manager.dart';
import 'package:employee_app/presentation/view_modals/login_viewModal.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isButtonDisabled = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    LoginViewModel.emailController.addListener(_validateInput);
    LoginViewModel.passwordController.addListener(_validateInput);
  }

  void _validateInput() {
    final usernameRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    final isUsernameValid =
        usernameRegex.hasMatch(LoginViewModel.emailController.text);
    final passwordRegex = RegExp(
        r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@!?\_])[a-zA-Z0-9@!?\_]{5,}$');

    final isPasswordValid =
        passwordRegex.hasMatch(LoginViewModel.passwordController.text);
    setState(() {
      _isButtonDisabled = LoginViewModel.emailController.text.isEmpty ||
          LoginViewModel.passwordController.text.isEmpty ||
          !isUsernameValid ||
          !isPasswordValid;
    });
  }

  void _signIn() {
    // Handle sign-in logic here
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * .35,
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Welcome Back",
                          style: getBoldtStyle(
                              color: ColorManager.textColor, fontSize: 20),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Text(
                            "Please Login to your account",
                            style: getRegularStyle(
                              color: ColorManager.textColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                color: ColorManager.primary,
              ),
              height: size.height * .65,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, top: 50, right: 25),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white),
                      child: TextFormField(
                        controller: LoginViewModel.emailController,
                        decoration: const InputDecoration(
                          hintText: 'Username',
                          prefixIcon: Icon(Icons.email),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, top: 20, right: 25),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white),
                      child: TextFormField(
                        controller: LoginViewModel.passwordController,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.key),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 10.0),
                        ),
                      ),
                    ),
                  ),
                  _isButtonDisabled
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 25, top: 30, right: 25),
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              final status = await UserLoginApi.login(context);
                              if (status) {
                                Navigator.pushReplacementNamed(
                                    context, Routes.homeScreen);
                                showAnimatedSnackBar(context, "User Logged IN",
                                    type: AnimatedSnackBarType.success);
                              } else {
                                showAnimatedSnackBar(context, "Invalid User",
                                    type: AnimatedSnackBarType.error);
                              }
                              setState(() {
                                _isLoading = false;
                              });
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.blue,
                              ),
                              child: Center(
                                child: _isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text('Sign In',
                                        style: getSemiBoldtStyle(
                                            color: Colors.white, fontSize: 16)),
                              ),
                            ),
                          ),
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
