import 'package:employee_app/data/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetDesignationWithId {
  static String getDes(BuildContext context, int id) {
    final provider = Provider.of<DataProvider>(context, listen: false);
    final designation = provider.designationModel?.data?.data;

    for (var i = 0; i < designation!.length; i++) {
      if (designation[i].id == id) {
        return designation[i].name ?? '';
      }
    }
    return '';
  }
}
