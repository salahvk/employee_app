import 'package:employee_app/config/route_manager.dart';
import 'package:employee_app/data/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataProvider()),
      ],
      child: MaterialApp(
        title: 'Employee App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const HomeScreen(),
        initialRoute: Routes.splashScreen,
        onGenerateRoute: RouteGenerator.getRoute,
      ),
    );
  }
}
