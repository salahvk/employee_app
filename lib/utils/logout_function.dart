// ignore_for_file: use_build_context_synchronously

import 'package:employee_app/config/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

logoutFun(BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('access_token');
  Navigator.pushNamedAndRemoveUntil(
    context,
    Routes.loginScreen,
    (route) => false,
  );
}
