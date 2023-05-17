// ignore_for_file: use_build_context_synchronously

import 'package:employee_app/config/route_manager.dart';
import 'package:employee_app/data/repositories/fetch_employees_data.dart';
import 'package:employee_app/utils/color_manager.dart';
import 'package:employee_app/utils/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:employee_app/data/repositories/fetch_designation.dart';
import 'package:employee_app/utils/asset_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initFun();
  }

  initFun() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('access_token');
      final BuildContext myContext = context;
      await Future.delayed(const Duration(seconds: 3));
      if (token == null) {
        Navigator.pushReplacementNamed(context, Routes.loginScreen);
      } else {
        await FetchEmployeesData.getData(myContext);
        await FetchDesignations.getData(myContext);
        Navigator.pushReplacementNamed(context, Routes.homeScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Lottie.asset(ImageAssets.splashLottie),
            Padding(
              padding: const EdgeInsets.only(top: 300),
              child: Text(
                "Employee App",
                style: getSemiBoldtStyle(
                    fontSize: 20, color: ColorManager.textColor),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 430),
              child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    color: Colors.amber,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
