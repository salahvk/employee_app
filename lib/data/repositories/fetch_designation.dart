// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:employee_app/data/endpoint.dart';
import 'package:employee_app/data/models/designatin_model.dart';
import 'package:employee_app/data/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchDesignations {
  static getData(BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final provider = Provider.of<DataProvider>(context, listen: false);
      final String? token = prefs.getString('access_token');
      var response = await http.get(Uri.parse(ApiEndPoint.designations),
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          });
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        final designationData = Designation.fromJson(jsonResponse);
        provider.designationModelData(designationData);
        log(response.body);
      } else if (response.statusCode == 401) {
        await prefs.remove('access_token');
      }
    } on Exception catch (_) {
      log("Something Went Wrong50");
    }
  }
}
