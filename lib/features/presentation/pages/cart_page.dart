import 'package:flutter/material.dart';
import 'package:mobileapp/controllers/add_to_cart.dart';
import 'package:mobileapp/features/data/datasources/bill_remote_datasource.dart';
import 'package:mobileapp/features/domain/entities/bill.dart';
import 'package:mobileapp/features/domain/entities/order.dart';
import 'package:mobileapp/features/presentation/viewmodels/bill_view_model.dart';
import 'package:mobileapp/features/presentation/viewmodels/order_view_model.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  final int customerID;
  const CartPage({super.key, required this.customerID});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cart = [];
  int sum = 0;

  @override
  void initState() {
    super.initState();
    cart = AddToCart.productCart;
    sum = AddToCart.getSumPrice();
  }

  void _removeItem(int index) {
    setState(() {
      AddToCart.productCart.removeAt(index);
      cart = AddToCart.productCart;
      sum = AddToCart.getSumPrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    final billVM = context.watch<BillViewModel>();
    final orderVM = context.watch<OrderViewModel>();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "ກະຕ່າຂອງຂ້ອຍ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body:
          cart.isEmpty
              ? const Center(child: Text("ບໍ່ມີລາຍການໃນກະຕ່າ"))
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final item = cart[index];

                        return Card(
                          elevation: 6,
                          margin: const EdgeInsets.only(bottom: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              children: [
                                /// IMAGE + NAME + REMOVE
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Product Image
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: _buildImage(item["image"]),
                                    ),

                                    const SizedBox(width: 12),

                                    /// Product info
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  item["name"],
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                ),
                                                onPressed:
                                                    () => _removeItem(index),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          _row("ລາຄາ", "${item["price"]} ກີບ"),
                                          _row("ຈຳນວນ", "${item["qty"]}"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),
                                _line(),
                                const SizedBox(height: 10),

                                /// TOTAL
                                _row(
                                  "ລວມ",
                                  "${item["total"]} ກີບ",
                                  isBold: true,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 8),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Total
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "ຍອດລວມທັງໝົດ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "$sum ກີບ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange.shade700,
                              ),
                            ),
                          ],
                        ),

                        /// Checkout Button
                        ElevatedButton(
                          onPressed: () {
                            String? transportType;
                            final TextEditingController branchController =
                                TextEditingController();

                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  title: Center(
                                    child: Text(
                                      "ກະລຸນາໃສ່ຂໍ້ມູນ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  content: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /// Dropdown ประเภทขนส่ง
                                        DropdownButtonFormField<String>(
                                          value: transportType,
                                          decoration: InputDecoration(
                                            labelText: "ປະເພດຂົນສົ່ງ",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.local_shipping,
                                            ),
                                          ),
                                          items: const [
                                            DropdownMenuItem(
                                              value: "ອະນຸສິດ",
                                              child: Text("ອະນຸສິດ"),
                                            ),
                                            DropdownMenuItem(
                                              value: "ມີໄຊ",
                                              child: Text("ມີໄຊ"),
                                            ),
                                          ],
                                          onChanged: (value) {
                                            transportType = value;
                                          },
                                        ),

                                        const SizedBox(height: 16),

                                        /// TextField ชื่อสาขา
                                        TextFormField(
                                          controller: branchController,
                                          decoration: InputDecoration(
                                            labelText: "ສາຂາຂົນສົ່ງ",
                                            hintText: "ປ້ອນຊື່ສາຂາ",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            prefixIcon: Icon(Icons.store),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "ຍົກເລີກ",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        await billVM.addBill(
                                          Bill(
                                            billID: null,
                                            customerID: widget.customerID,
                                            logistictType:
                                                transportType.toString(),
                                            logisticName: branchController.text,
                                            billdate: null,
                                            send: null,
                                          ),
                                        );
                                        int BillId = BillRemoteDatasource.id;
                                        print(BillId);

                                        for (var item in cart) {
                                          await orderVM.addOrder(
                                            Order(
                                              orderID: null,
                                              billID: BillId,
                                              productID: item["id"],
                                              saleQty: item["qty"],
                                              total: item["total"],
                                            ),
                                          );
                                        }

                                        setState(() {
                                          AddToCart.productCart = [];
                                          cart = AddToCart.productCart;
                                          sum = AddToCart.getSumPrice();
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Text("ບັນທຶກ"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade600,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Container(
                            height: 35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.save, size: 20, color: Colors.white),
                                SizedBox(width: 5),
                                Text(
                                  "ບັນທຶກການສັ່ງຊື້",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }

  /// IMAGE HANDLER (URL or Asset)
  Widget _buildImage(String image) {
    if (image.startsWith('http')) {
      return Image.network(
        image,
        width: 90,
        height: 90,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
      );
    } else {
      return Image.asset(image, width: 90, height: 90, fit: BoxFit.fill);
    }
  }

  Widget _row(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _line() {
    return Container(height: 1, color: Colors.grey.shade300);
  }
}
