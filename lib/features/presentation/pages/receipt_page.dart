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
    data = AddToCart.productCart;
  }

  double get totalAmount {
    return data.fold(0, (sum, item) => sum + (item["total"] as num).toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: Text(
          "ລະຫັດໃບບິນ: #${widget.id}",
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "LAO SHOP",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade900,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              subtitle: Container(
                alignment: Alignment.center,
                child: Text(
                  "ກະລຸນາແຄັບຈໍໃບບິນໄວ້ເພື່ອຢືນຢັນ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "ໃບບິນການສັ່ງຊື້",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(),

                    /// ===== TABLE HEADER =====
                    Row(
                      children: const [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "ລາຍການ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "ລາຄາ",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "ຈຳນວນ",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "ລວມ",
                            textAlign: TextAlign.end,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),

                    /// ===== TABLE BODY =====
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final item = data[index];
                        return Row(
                          children: [
                            Expanded(flex: 3, child: Text(item["name"])),
                            Expanded(
                              child: Text(
                                item["price"].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item["qty"].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item["total"].toString(),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const Divider(thickness: 1.2),

                    /// ===== TOTAL =====
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "ຍອດລວມທັງໝົດ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${totalAmount.toStringAsFixed(0)} ກີບ",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            /// ===== CONFIRM BUTTON =====
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  AddToCart.productCart = [];
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomePage(userID: widget.customerId),
                    ),
                    (route) => false,
                  );
                },
                child: const Text(
                  "ຢືນຢັນການສັ່ງຊື້",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
