import 'package:dealsdray_assignment/pages/home_screen.dart';
import 'package:dealsdray_assignment/pages/splash_screen.dart';
import 'package:dealsdray_assignment/utils/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deals Dray',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/splashScreen',
      routes: {
        MyRoutes.splashScreen :(context) => SplashScreen(),
        MyRoutes.homeRoute :(context) => HomeScreen()
      },
    );
  }
}
