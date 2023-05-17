import 'package:employee_app/data/models/employees_model.dart';
import 'package:employee_app/data/models/designatin_model.dart';
import 'package:flutter/material.dart';

class DataProvider with ChangeNotifier {
  EmployeesModel? employeesModel;
  Designation? designationModel;

  void employeesModelData(EmployeesModel value) {
    if (employeesModel?.data != null && employeesModel?.data?.data != null) {
      for (var data in value.data!.data!) {
        employeesModel?.data?.data?.add(data);
      }
    } else {
      employeesModel = value;
    }
    notifyListeners();
  }

  void designationModelData(value) {
    designationModel = value;
    notifyListeners();
  }
}
