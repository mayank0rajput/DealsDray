import 'package:dealsdray_assignment/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  bool _buttonDisable = true; // Initialize as true to disable the button by default
  bool isPhoneSelected = true; // Track toggle selection
  bool _processIndicator = false;

  String? _validateEmail(String? value) {
    final emailExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    } else if (!emailExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    phoneController.addListener(_checkInput);
    emailController.addListener(_checkInput);
  }

  void _checkInput() {
    setState(() {
      _buttonDisable = isPhoneSelected
          ? phoneController.text.isEmpty
          : emailController.text.isEmpty;
    });
  }

  Future<void> _sendPhoneData() async {
    var url = Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/otp');

    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "mobileNumber": phoneController.text,
          "deviceId": "62b341aeb0ab5ebe28a758a3",
        }),
      );

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
        Navigator.pushReplacementNamed(context, MyRoutes.otpScreen,arguments: phoneController.text);
      }
      else {
        print('Status Code: ${response.statusCode}');
        print('Reason: ${response.reasonPhrase}');
        print('Response: ${response.body}');
        // You might want to show an error message here
      }
    } catch (e) {
      print('Exception: $e');
      // You might want to show an error message here
    }
    _processIndicator = false;
    Navigator.pushReplacementNamed(context, MyRoutes.otpScreen,arguments: phoneController.text);
  }

  Future<void> _sendEmailData() async {
    // Example for sending email data
    print('Send email data');
    Navigator.pushReplacementNamed(context, MyRoutes.otpScreen);
  }

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/dealsdray_logo.png',
                opacity: const AlwaysStoppedAnimation(0.5),
              ),
              const SizedBox(height: 20),
              // Toggle Buttons for Phone / Email
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildSegmentButton(0, "Phone"),
                    _buildSegmentButton(1, "Email"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Glad to see you!',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w800,
                          fontSize: 32,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Please provide your details',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Show Phone or Email input based on selection
                    Column(
                      children: <Widget>[
                        isPhoneSelected
                            ? TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            hintText: '9011470243',
                          ),
                          validator: (value){
                            final phoneExp = RegExp(r'^\d{10}$');
                            if (value == null || value.isEmpty) {
                              return 'Please enter a phone number';
                            } else if (!phoneExp.hasMatch(value)) {
                              return 'Please enter a valid 10-digit phone number';
                            }
                            return null;
                          },
                        )
                            : TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                          ),
                          validator: _validateEmail,
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: _buttonDisable
                              ? null
                              : () {
                            _processIndicator = true;
                            setState(() {});
                            isPhoneSelected
                                ? _sendPhoneData()
                                : _sendEmailData();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'SEND CODE',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    _processIndicator ?
                    CircularProgressIndicator()
                        : SizedBox.shrink()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build each segment (Phone or Email)
  Widget _buildSegmentButton(int index, String label) {
    bool isSelected = (index == 0 && isPhoneSelected) || (index == 1 && !isPhoneSelected);
    return GestureDetector(
      onTap: () {
        setState(() {
          isPhoneSelected = index == 0; // 0 is for Phone, 1 is for Email
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.grey[300],
          borderRadius: index == 0
              ? const BorderRadius.only(
            topLeft: Radius.circular(25.0),
            bottomLeft: Radius.circular(25.0),
          )
              : const BorderRadius.only(
            topRight: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
