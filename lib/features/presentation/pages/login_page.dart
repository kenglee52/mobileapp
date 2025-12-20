import 'package:flutter/material.dart';
import 'package:mobileapp/core/wigets/colors/color_wiget.dart';
import 'package:mobileapp/core/wigets/textfields/text_form_fields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = true;
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  void showPass() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: ColorWiget.bgGradient,
            begin: AlignmentGeometry.topLeft,
            end: AlignmentGeometry.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormFields.txtNumber(
                  "Tel number",
                  Icon(Icons.phone, color: Colors.blue.shade700),
                  phone,
                ),
                SizedBox(height: 15),
                TextFormFields.txtPassword(
                  "Password",
                  Icon(Icons.lock, color: Colors.blue.shade700),
                  password,
                  showPassword,
                  showPass,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
