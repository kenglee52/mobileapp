import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/config/Api.dart';
import 'package:http/http.dart' as http;
import 'package:mobileapp/features/presentation/pages/layout/home_page.dart';
import 'package:mobileapp/features/presentation/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _telController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _eyeOpen = true;

  Future<void> login(String tel, String password) async {
    final String url = Api.baseUrl + "/customer-login";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"customerTel": tel, "customerPassword": password}),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        int id = data["data"]["customerID"];

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage(userID: id)),
        );
      } else {
        _showError("ເບີໂທ ຫຼື ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ");
      }
    } catch (e) {
      _showError("ເກີດຂໍ້ຜິດພາດ");
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD32F2F), Color(0xFFB71C1C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 30,
                shadowColor: Color(0xFFD32F2F).withOpacity(0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// 🛒 Logo
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Color(0xFFD32F2F),
                        child: const Icon(
                          Icons.shopping_cart,
                          size: 36,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        "LAO SHOP",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          color: Color(0xFFD32F2F),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "ເຂົ້າສູ່ລະບົບເພື່ອຊື້ສິນຄ້າ",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),

                      const SizedBox(height: 30),

                      /// 📞 Tel
                      TextField(
                        controller: _telController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "ເບີໂທ",
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Color(0xFFD32F2F),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Color(0xFFD32F2F).withOpacity(0.3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Color(0xFFD32F2F), width: 2),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      /// 🔐 Password
                      TextField(
                        controller: _passwordController,
                        obscureText: _eyeOpen,
                        decoration: InputDecoration(
                          labelText: "ລະຫັດຜ່ານ",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xFFD32F2F),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _eyeOpen
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Color(0xFFD32F2F),
                            ),
                            onPressed: () {
                              setState(() => _eyeOpen = !_eyeOpen);
                            },
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Color(0xFFD32F2F).withOpacity(0.3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Color(0xFFD32F2F), width: 2),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      /// 🔘 Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFD32F2F),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () {
                            login(
                              _telController.text,
                              _passwordController.text,
                            );
                          },
                          child: const Text(
                            "ເຂົ້າສູ່ລະບົບ",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      /// 📝 Register
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => RegisterPage()),
                          );
                        },
                        child: const Text(
                          "ຍັງບໍ່ມີບັນຊີ? ລົງທະບຽນ",
                          style: TextStyle(
                            color: Color(0xFFD32F2F),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
