import 'package:dealsdray_assignment/pages/home_screen.dart';
import 'package:dealsdray_assignment/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    // await sendDeviceData();
    Navigator.pushReplacementNamed(
        context, MyRoutes.homeRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
            child: Column(
              children: [
                Expanded(child: Image.asset("assets/img.png",fit: BoxFit.contain))
          ],
        )
        ),
      ),
    );
  }
}
