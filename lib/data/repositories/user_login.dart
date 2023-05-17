// ignore_for_file: await_only_futures, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:employee_app/data/endpoint.dart';
import 'package:employee_app/data/repositories/fetch_employees_data.dart';
import 'package:employee_app/data/repositories/fetch_designation.dart';
import 'package:employee_app/presentation/view_modals/login_viewModal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginApi {
  static Future<bool> login(BuildContext context) async {
    try {
      final url =
          "${ApiEndPoint.login}?email=${LoginViewModel.emailController.text}&password=${LoginViewModel.passwordController.text}";
      var response = await http.post(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        final accessToken = jsonResponse["data"]["access_token"];
        print(accessToken);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', accessToken);
        await FetchEmployeesData.getData(context);
        await FetchDesignations.getData(context);
        log(response.body);
        return true;
      } else {
        log("Something Went Wrong50");
        return false;
      }
    } on Exception catch (_) {
      log("Something Went Wrong50");
    }

    return false;
  }
}
