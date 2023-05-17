import 'package:employee_app/utils/style_manager.dart';
import 'package:flutter/material.dart';

InputDecoration buildInputDecoration() {
  return InputDecoration(
    hintStyle: getRegularStyle(color: Colors.grey, fontSize: 12),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Color.fromARGB(255, 2, 76, 136)),
    ),
  );
}
