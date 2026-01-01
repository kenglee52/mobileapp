import 'package:flutter/material.dart';
import 'package:mobileapp/controllers/add_to_cart.dart';

class ProductDetailPage extends StatefulWidget {
  final int id;
  final String name;
  final String category;
  final String unit;
  final String image;
  final int price;
  final int stockQuatity;
  final String decoration;

  const ProductDetailPage({
    super.key,
    required this.id,
    required this.name,
    required this.category,
    required this.unit,
    required this.image,
    required this.price,
    required this.stockQuatity,
    required this.decoration,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quntity = 1;
  int total = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      total = widget.price * quntity;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xFFD32F2F)),
      ),
      extendBodyBehindAppBar: true,

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 15, color: Colors.black.withOpacity(0.08)),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFD32F2F),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 4,
          ),
          onPressed: () {
            int checkQty = widget.stockQuatity - quntity;
            if (checkQty <= 30) {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text("ຈຳນວນສິນຄ້າບໍ່ພຽງພໍ"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("ຕົກລົງ"),
                        ),
                      ],
                    ),
              );
              return;
            }
            AddToCart.addProduct(
              widget.id,
              widget.name,
              widget.price,
              quntity,
              total,
              widget.image,
              widget.stockQuatity,
            );
          },
          child: Container(
            height: 26,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.shopping_cart, size: 22, color: Colors.white),
                SizedBox(width: 5),
                Text(
                  "ເພີ່ມເຂົ້າກະຕ່າ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          /// 🔥 Hero Image
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.38,
                width: double.infinity,
                child: Image.network(widget.image, fit: BoxFit.fill),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.38,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  ),
                ),
              ),
            ],
          ),

          /// 📦 Detail Card
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Product Name
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF424242),
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// Category + Unit
                  Text(
                    "${widget.category} • ${widget.unit}",
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),

                  const SizedBox(height: 16),

                  /// Price
                  Text(
                    "${widget.price.toString()} ₭",
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD32F2F),
                    ),
                  ),

                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFD32F2F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            if (quntity <= 1) {
                              return;
                            }
                            quntity = quntity - 1;
                            total = widget.price * quntity;
                          });
                        },
                        child: const Icon(Icons.remove, color: Colors.white),
                      ),
                      Text(
                        "ຈຳນວນ: ${quntity} ${widget.unit}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFD32F2F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            quntity = quntity + 1;
                            total = widget.price * quntity;
                          });
                        },
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "ລວມ: ${total} ກີບ",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFFD32F2F),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 3),

                  Divider(color: Colors.grey.shade300),

                  const SizedBox(height: 16),

                  /// Description
                  const Text(
                    "ລາຍລະອຽດສິນຄ້າ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF424242),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "${widget.decoration}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
