import 'package:flutter/material.dart';
import 'package:mobileapp/controllers/add_to_cart.dart';
import 'package:mobileapp/features/data/datasources/bill_remote_datasource.dart';
import 'package:mobileapp/features/domain/entities/bill.dart';
import 'package:mobileapp/features/domain/entities/category.dart';
import 'package:mobileapp/features/domain/entities/order.dart';
import 'package:mobileapp/features/domain/entities/product.dart';
import 'package:mobileapp/features/domain/entities/unit.dart';
import 'package:mobileapp/features/presentation/pages/receipt_page.dart';
import 'package:mobileapp/features/presentation/viewmodels/bill_view_model.dart';
import 'package:mobileapp/features/presentation/viewmodels/order_view_model.dart';
import 'package:mobileapp/features/presentation/viewmodels/product_view_model.dart';
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
    final productVM = context.watch<ProductViewModel>();
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Color(0xFFD32F2F),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 4,
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
                          elevation: 2,
                          margin: const EdgeInsets.only(bottom: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: _buildImage(item["image"]),
                                    ),
                                    const SizedBox(width: 12),
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
                                                    color: Color(0xFF424242),
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Color(0xFFD32F2F),
                                                  size: 22,
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
                                  color: Color(0xFFD32F2F),
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
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD32F2F),
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
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Color(0xFFD32F2F),
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
                                              color: Color(0xFFD32F2F),
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
                                            prefixIcon: Icon(
                                              Icons.store,
                                              color: Color(0xFFD32F2F),
                                            ),
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
                                      child: const Text(
                                        "ຍົກເລີກ",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFD32F2F),
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
                                          Product? fullProduct;
                                          try {
                                            fullProduct = productVM.product
                                                .firstWhere(
                                                  (p) =>
                                                      p.productID == item["id"],
                                                );
                                          } catch (e) {
                                            fullProduct = Product(
                                              productID: item["id"],
                                              productName: item["name"],
                                              categoryID: item["categoryID"],
                                              unitID: item["unitID"],
                                              stockQty: item["stock"],
                                              price: item["price"],
                                              image: item["image"],
                                              importPrice: item["importPrice"],
                                              manufature: item["manufature"],
                                              expiry: item["expiry"],
                                              description: item["description"],
                                              category: Category(
                                                categoryID: item["categoryID"],
                                                categoryName: "",
                                              ),
                                              unit: Unit(
                                                unitID: item["unitID"],
                                                unitName: "",
                                              ),
                                            );
                                          }
                                          int newQtyInStock =
                                              item["stock"] - item["qty"];
                                          await productVM.editProduct(
                                            Product(
                                              productID: item["id"],
                                              productName:
                                                  fullProduct.productName,
                                              categoryID:
                                                  fullProduct.categoryID,
                                              unitID: fullProduct.unitID,
                                              stockQty: newQtyInStock,
                                              price: fullProduct.price,
                                              image: fullProduct.image,
                                              importPrice:
                                                  fullProduct.importPrice,
                                              manufature:
                                                  fullProduct.manufature,
                                              expiry: fullProduct.expiry,
                                              description:
                                                  fullProduct.description,
                                              category: fullProduct.category,
                                              unit: fullProduct.unit,
                                            ),
                                          );
                                        }
                                        Navigator.pop(context);
                                        showDialog(
                                          context: context,
                                          builder:
                                              (context) => AlertDialog(
                                                title: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "ສຳເລັດການສັ່ງສື້",
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      // Navigator.pop(context);
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder:
                                                              (
                                                                context,
                                                              ) => ReceiptPage(
                                                                id: BillId,
                                                                customerId:
                                                                    widget
                                                                        .customerID,
                                                              ),
                                                        ),
                                                      );
                                                    },
                                                    child: Text("ຕົກລົງ"),
                                                  ),
                                                ],
                                              ),
                                        );
                                      },
                                      child: const Text("ບັນທຶກ"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFD32F2F),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                          ),
                          child: Container(
                            height: 26,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
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

  Widget _row(String title, String value, {bool isBold = false, Color? color}) {
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
              color: color,
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
