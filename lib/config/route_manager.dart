import 'package:employee_app/presentation/screens/add_employee_screen.dart';
import 'package:employee_app/presentation/screens/home_screen.dart';
import 'package:employee_app/presentation/screens/login_screen.dart';
import 'package:employee_app/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashScreen = '/';
  static const String loginScreen = '/loginScreen';
  static const String homeScreen = '/homeScreen';
  static const String addEmployeeScreen = '/addEmployeeScreen';
  // static const String employeeDetailScreen = '/employeeDetailScreen';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.addEmployeeScreen:
        return MaterialPageRoute(builder: (_) => const AddEmployeeScreen());
      // case Routes.employeeDetailScreen:
      //   return MaterialPageRoute(builder: (_) => const EmployeeDetailScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text("No Route Found"),
        ),
        body: const Center(
          child: Text("No Route Found"),
        ),
      ),
    );
  }
}
