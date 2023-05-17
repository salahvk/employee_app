// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:employee_app/config/route_manager.dart';
import 'package:employee_app/data/endpoint.dart';
import 'package:employee_app/data/repositories/fetch_employees_data.dart';
import 'package:employee_app/presentation/view_modals/add_emp_viewModal.dart';
import 'package:employee_app/utils/animated_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

class AddEmployeeDetails {
  addData(XFile? file, XFile? file2, BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('access_token');
      final fName = AddViewModel.firstNameController.text;

      final lName = AddViewModel.lastNameController.text;
      final mobile = AddViewModel.mobController.text;
      final mail = AddViewModel.emailController.text;
      final address = AddViewModel.addressController.text;
      final dob = AddViewModel.birthDateController.text;
      final des = AddViewModel.designationController.text;
      final gender = AddViewModel.genDerController.text;
      final usernameRegex =
          RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
      bool validMail = usernameRegex.hasMatch(mail);
      if (fName.isEmpty || lName.isEmpty) {
        showAnimatedSnackBar(context, "Name is Mandatory",
            type: AnimatedSnackBarType.error);
      } else if (mobile.length < 10) {
        showAnimatedSnackBar(context, "Mobile No must be 10 digits",
            type: AnimatedSnackBarType.error);
      } else if (mail.isEmpty || validMail == false) {
        showAnimatedSnackBar(context, "Invalid Mail",
            type: AnimatedSnackBarType.error);
      } else if (address.isEmpty) {
        showAnimatedSnackBar(context, "Address is Mandatory",
            type: AnimatedSnackBarType.error);
      } else if (dob.isEmpty) {
        showAnimatedSnackBar(context, "DOB is Mandatory",
            type: AnimatedSnackBarType.error);
      } else if (des.isEmpty) {
        showAnimatedSnackBar(context, "Designation is Mandatory",
            type: AnimatedSnackBarType.error);
      } else if (gender.isEmpty) {
        showAnimatedSnackBar(context, "Gender is Mandatory",
            type: AnimatedSnackBarType.error);
      } else if (file == null) {
        showAnimatedSnackBar(context, "Profile picture is Mandatory",
            type: AnimatedSnackBarType.error);
      } else if (file2 == null) {
        showAnimatedSnackBar(context, "Resume is Mandatory",
            type: AnimatedSnackBarType.error);
      } else {
        final url =
            "${ApiEndPoint.employeesDetails}?first_name=$fName&last_name=$lName&join_date=12-12-2023&date_of_birth=$dob&designation_id=$des&gender=$gender&email=$mail&mobile=$mobile&landline=1111111&present_address=$address&permanent_address=ss&status=TEMPORERY&";
        var request = http.MultipartRequest(
          "POST",
          Uri.parse(url),
        );
        request.headers.addAll(
            {"Authorization": "Bearer $token", "Accept": "application/json"});
        var stream = http.ByteStream(DelegatingStream(file.openRead()));
        var length = await file.length();
        var multipartFile = http.MultipartFile(
          'profile_picture',
          stream,
          length,
          filename: (file.path),
        );
        var stream2 = http.ByteStream(DelegatingStream(file2.openRead()));
        var length2 = await file2.length();
        var multipartFile2 = http.MultipartFile(
          'resume',
          stream2,
          length2,
          filename: (file2.path),
        );
        request.files.add(multipartFile);
        request.files.add(multipartFile2);
        var res = await request.send();
        final response = await http.Response.fromStream(res);
        if (response.statusCode == 200) {
          log(response.body);
          await FetchEmployeesData.getData(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.homeScreen,
            (route) => false,
          );
        } else if (response.statusCode == 401) {
          log(response.body);
        }
        log(response.body);
      }
    } on Exception catch (e) {
      log("Something Went Wrong50");
      print(e);
    } catch (_) {}
  }
}
