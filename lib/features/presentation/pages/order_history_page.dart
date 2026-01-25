import 'package:flutter/material.dart';
import 'package:mobileapp/reports/report.dart';

class OrderHistoryPage extends StatefulWidget {
  final int id;
  const OrderHistoryPage({super.key, required this.id});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  List<Map<String, dynamic>> items = [];
  int sum = 0;
  Future<void> fetchData(int id) async {
    await Report.fetchOrder(id);
    setState(() {
      items = Report.orders;
    });
  }

  int sumTotal() {
    for (var item in items) {
      int total = item["total"];
      sum = sum + total;
    }
    return sum;
  }

  @override
  void initState() {
    super.initState();
    fetchData(widget.id);
    setState(() {
      sumTotal();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "ລະຫັດໃບບິນ: ${widget.id}",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body:
          items.isEmpty
              ? Center(child: Text("ກຳລັງໂຫລດ...."))
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 15,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 18,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "ສິນຄ້າ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "ລາຄາ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "ຈຳນວນ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "ລວມ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: items.length,
                            separatorBuilder: (_, __) => const Divider(),
                            itemBuilder: (context, index) {
                              final item = items[index];
                              return Container(
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(item["productName"]),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          item["price"].toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        item["saleQty"].toString(),
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
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "ລວມທັງໝົດ: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "${sumTotal()}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade900,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
