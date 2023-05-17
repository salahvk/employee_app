import 'package:employee_app/data/models/employees_model.dart';
import 'package:employee_app/utils/color_manager.dart';
import 'package:employee_app/utils/get_designation.dart';
import 'package:employee_app/utils/style_manager.dart';
import 'package:flutter/material.dart';

class EmployeeDetailScreen extends StatelessWidget {
  final Data data;
  const EmployeeDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final designation =
        GetDesignationWithId.getDes(context, data.designationId ?? 0);
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios,
          color: ColorManager.textColor,
        ),
        backgroundColor: ColorManager.primary,
        title: Text(
          "${data.firstName} ${data.lastName}",
          style: getSemiBoldtStyle(color: ColorManager.textColor, fontSize: 16),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 10),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(data.profileImage!),
              ),
            ),
            Text(
              "${data.firstName} ${data.lastName}",
              style:
                  getRegularStyle(color: ColorManager.textColor, fontSize: 16),
            ),
            Text(
              designation,
              style:
                  getRegularStyle(color: ColorManager.textColor, fontSize: 12),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: const Color.fromARGB(255, 222, 222, 222))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Contact Number",
                                  style: getRegularStyle(
                                      color: ColorManager.textColor,
                                      fontSize: 14),
                                ),
                                Text(
                                  data.mobile.toString(),
                                  style: getRegularStyle(
                                      color: ColorManager.textColor2,
                                      fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Date of birth",
                                  style: getRegularStyle(
                                      color: ColorManager.textColor,
                                      fontSize: 14),
                                ),
                                Text(
                                  data.dateOfBirth!.substring(0, 10),
                                  style: getRegularStyle(
                                      color: ColorManager.textColor2,
                                      fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Address",
                                  style: getRegularStyle(
                                      color: ColorManager.textColor,
                                      fontSize: 16),
                                ),
                                Text(
                                  data.presentAddress ?? '',
                                  style: getRegularStyle(
                                      color: ColorManager.textColor,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: size.width * .35,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email",
                                  style: getRegularStyle(
                                      color: ColorManager.textColor,
                                      fontSize: 14),
                                ),
                                Text(
                                  data.email ?? '',
                                  style: getRegularStyle(
                                      color: ColorManager.textColor2,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: size.width * .35,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Gender",
                                  style: getRegularStyle(
                                      color: ColorManager.textColor,
                                      fontSize: 16),
                                ),
                                Text(
                                  data.gender ?? '',
                                  style: getRegularStyle(
                                      color: ColorManager.textColor,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
