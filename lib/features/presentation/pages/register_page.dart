import 'package:flutter/material.dart';
import 'package:mobileapp/features/domain/entities/customer.dart';
import 'package:mobileapp/features/presentation/viewmodels/customer_view_model.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController telController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CustomerViewModel>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey.shade800, Colors.grey.shade900],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 30,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// 👤 Icon
                      CircleAvatar(
                        radius: 38,
                        backgroundColor: Colors.orange.shade600,
                        child: const Icon(
                          Icons.person_add_alt_1,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        "ລົງທະບຽນ",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "ສ້າງບັນຊີເພື່ອເລີ່ມຊື້ສິນຄ້າ",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),

                      const SizedBox(height: 30),

                      /// 🧑 Name
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "ຊື່",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.orange.shade600,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      /// 📞 Tel
                      TextField(
                        controller: telController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "ເບີໂທ",
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.orange.shade600,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      /// 🔐 Password
                      TextField(
                        controller: passwordController,
                        obscureText: _hidePassword,
                        decoration: InputDecoration(
                          labelText: "ລະຫັດຜ່ານ",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.orange.shade600,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() => _hidePassword = !_hidePassword);
                            },
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// 🔘 Register Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange.shade600,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed:
                              vm.isLoading
                                  ? null
                                  : () async {
                                    await vm.addCustomer(
                                      Customer(
                                        customerID: null,
                                        customerName: nameController.text,
                                        customerTel: telController.text,
                                        customerPassword:
                                            passwordController.text,
                                      ),
                                    );
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
                                  },
                          child:
                              vm.isLoading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : const Text(
                                    "ລົງທະບຽນ",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      /// 🔙 Back to Login
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "ມີບັນຊີແລ້ວ? ເຂົ້າສູ່ລະບົບ",
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w500,
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
