import 'package:dealsdray_assignment/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    await _sendDeviceData();
    Navigator.pushReplacementNamed(
        context, MyRoutes.login);
  }

  Future<void> _sendDeviceData() async {
    var url = Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/device/add');

    var request = http.Request('POST', url);

    request.body = '''{
      "deviceType": "andriod",
      "deviceId": "C6179909526098",
      "deviceName": "Samsung-MT200",
      "deviceOSVersion": "2.3.6",
      "deviceIPAddress": "11.433.445.66",
      "lat": 9.9312,
      "long": 76.2673,
      "buyer_gcmid": "",
      "buyer_pemid": "",
      "app": {
          "version": "1.20.5",
          "installTimeStamp": "2022-02-10T12:33:30.696Z",
          "uninstallTimeStamp": "2022-02-10T12:33:30.696Z",
          "downloadTimeStamp": "2022-02-10T12:33:30.696Z"
      }
    }''';

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        print(responseBody);
        Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }


  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: CircularProgressIndicator(),
            ),
            const SizedBox(
              height: 50,
            ),
            Image.asset('assets/dealsdray_logo.png'),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
    // return Scaffold(
    //   body: Center(
    //     child: Container(
    //       width: double.infinity,
    //         child: Column(
    //           children: [
    //             Expanded(child: Image.asset("assets/img.png",fit: BoxFit.contain))
    //       ],
    //     )
    //     ),
    //   ),
    // );
  }
}
