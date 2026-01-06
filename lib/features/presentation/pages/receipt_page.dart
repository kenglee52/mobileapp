import 'package:flutter/material.dart';
import 'package:mobileapp/controllers/add_to_cart.dart';
import 'package:mobileapp/features/presentation/pages/layout/home_page.dart';

class ReceiptPage extends StatefulWidget {
  final int id;
  final int customerId;
  const ReceiptPage({super.key, required this.id, required this.customerId});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  List<Map<String, dynamic>> data = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      data = AddToCart.productCart;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: Text("ລະຫັດບິນ: ${widget.id} ${widget.customerId}"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return ListTile(title: Text("${item["name"]}"));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
              ),
              onPressed: () {
                setState(() {
                  AddToCart.productCart = [];
                });
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(userID: widget.customerId),
                  ),
                );
              },
              child: Container(
                height: 26,
                child: Text(
                  "ຢືນຢັນ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
