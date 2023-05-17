// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:employee_app/data/models/designatin_model.dart';
import 'package:employee_app/data/providers/data_provider.dart';
import 'package:employee_app/data/repositories/add_employee.dart';
import 'package:employee_app/utils/color_manager.dart';
import 'package:employee_app/utils/style_manager.dart';
import 'package:employee_app/utils/asset_manager.dart';
import 'package:employee_app/presentation/view_modals/add_emp_viewModal.dart';
import 'package:employee_app/presentation/view_modals/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  bool isLoading = false;
  DateTime selectedDate = DateTime.now();
  String? selectedGender;
  String? defDesignation;
  final ImagePicker _picker = ImagePicker();
  String? imagePath;
  XFile? resume;
  String? resumeName;
  XFile? imageFile;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme:
                    const ColorScheme.light(primary: ColorManager.secondary)),
            child: child!,
          );
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        AddViewModel.birthDateController.text =
            selectedDate.toLocal().toString().split(' ')[0];
      });
    }
  }

  selectImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagePath = image?.path;
      imageFile = image;
    });
    if (image == null) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorManager.textColor,
          ),
        ),
        backgroundColor: ColorManager.primary,
        title: Text(
          "Add an employee",
          style: getSemiBoldtStyle(color: ColorManager.textColor, fontSize: 16),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(4, 4.5),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorManager.primary,
                      radius: 50,
                      backgroundImage: imagePath != null
                          ? FileImage(File(imagePath!))
                          : const AssetImage(ImageAssets.user) as ImageProvider,
                    ),
                    Positioned(
                        right: 0,
                        bottom: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(2, 2.5),
                              ),
                            ],
                          ),
                          child: Material(
                            shape: const CircleBorder(),
                            color: Colors.white,
                            child: InkWell(
                              splashColor: ColorManager.primary,
                              customBorder: const CircleBorder(),
                              enableFeedback: true,
                              excludeFromSemantics: true,
                              onTap: selectImage,
                              child: const CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.transparent,
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      "First Name",
                      style: getRegularStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: TextField(
                    controller: AddViewModel.firstNameController,
                    decoration: buildInputDecoration().copyWith(
                      hintText: "Enter Name",
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      "Last Name",
                      style: getRegularStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: TextField(
                    controller: AddViewModel.lastNameController,
                    decoration: buildInputDecoration().copyWith(
                      hintText: "Enter Name",
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      "Mobile Number",
                      style: getRegularStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: TextField(
                    controller: AddViewModel.mobController,
                    keyboardType: TextInputType.number,
                    decoration: buildInputDecoration().copyWith(
                      hintText: "Enter Mobile Number",
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      "Email",
                      style: getRegularStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: AddViewModel.emailController,
                    decoration: buildInputDecoration().copyWith(
                      hintText: "Enter Mail Address",
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      "Address",
                      style: getRegularStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: TextField(
                    controller: AddViewModel.addressController,
                    minLines: 3,
                    maxLines: 4,
                    decoration: buildInputDecoration().copyWith(
                      hintText: "Enter Address",
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      "Date of birth",
                      style: getRegularStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: TextField(
                    controller: AddViewModel.birthDateController,
                    decoration: buildInputDecoration().copyWith(
                      hintText: "6/12/2020",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () {
                          _selectDate(context);
                        },
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      "Designation",
                      style: getRegularStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
                child: Container(
                  // width: size.width * .44,
                  decoration: BoxDecoration(
                      // color: Colormanager.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<Data>(
                      isExpanded: true,
                      iconStyleData: const IconStyleData(),
                      hint: Text("Select One",
                          style: getRegularStyle(
                              color: const Color.fromARGB(255, 173, 173, 173),
                              fontSize: 12)),
                      items: provider.designationModel?.data?.data
                          ?.map((item) => DropdownMenuItem<Data>(
                                value: item,
                                child: Text(item.name ?? '',
                                    style: getRegularStyle(
                                        color: ColorManager.textColor,
                                        fontSize: 15)),
                              ))
                          .toList(),
                      // value: defCategory,
                      onChanged: (value) {
                        setState(() {
                          defDesignation = value?.name as String;
                        });
                        AddViewModel.designationController.text =
                            value?.id.toString() ?? '';
                      },

                      customButton: defDesignation == null
                          ? null
                          : Row(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 15, 10, 15),
                                    child: Text(
                                      defDesignation ?? '',
                                      style: getRegularStyle(
                                        color: ColorManager.textColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      "Gender",
                      style: getRegularStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        "Select Gender",
                        style: getRegularStyle(
                          color: const Color.fromARGB(255, 173, 173, 173),
                          fontSize: 12,
                        ),
                      ),
                      value: selectedGender,
                      onChanged: (String? value) {
                        setState(() {
                          selectedGender = value;
                          AddViewModel.genDerController.text = value ?? '';
                        });
                      },
                      items: [
                        DropdownMenuItem<String>(
                          value: "Male",
                          child: Text(
                            "Male",
                            style: getRegularStyle(
                              color: ColorManager.textColor,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: "Female",
                          child: Text(
                            "Female",
                            style: getRegularStyle(
                              color: ColorManager.textColor,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: [
                        'pdf',
                        'doc',
                        'xls',
                      ],
                    );

                    if (result != null) {
                      PlatformFile file = result.files.first;
                      setState(() {
                        resumeName = file.name;
                      });
                      final path = file.path;

                      resume = XFile(path!);
                    } else {}
                  },
                  child: Container(
                    color: ColorManager.primary,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: resumeName != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(resumeName ?? ''),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.upload),
                                Text(
                                  "Upload Resume",
                                  style: getRegularStyle(
                                      color: ColorManager.textColor,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                child: InkWell(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await AddEmployeeDetails()
                        .addData(imageFile, resume, context);
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text('Save',
                              style: getSemiBoldtStyle(
                                  color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
