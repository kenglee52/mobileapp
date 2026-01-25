import 'package:flutter/material.dart';
import 'package:mobileapp/features/presentation/pages/order_history_page.dart';
import 'package:mobileapp/reports/report.dart';

class HistoryPage extends StatefulWidget {
  final int id;
  const HistoryPage({super.key, required this.id});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> data = [];
  Future<void> fetchData(int id) async {
    await Report.fetchBill(id);
    setState(() {
      data = Report.bill;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData(widget.id);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "ປະຫວັດການສັ່ງຊື້",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return Card(
              elevation: 5,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              OrderHistoryPage(id: item["onlineBillID"]),
                    ),
                  );
                },
                title: Row(
                  children: [
                    Text(
                      "ລະຫັດບິນ: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${item["onlineBillID"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade900,
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  "ວັນທີ: ${item["onlineBillDate"]}",
                  style: TextStyle(color: Colors.black),
                ),
                trailing:
                    item["send"] == 0
                        ? Text(
                          "ບໍ່ທັນຈັດສົ່ງ",
                          style: TextStyle(
                            color: Colors.red.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        )
                        : Text(
                          "ຈັດສົ່ງແລ້ວ",
                          style: TextStyle(
                            color: Colors.green.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
              ),
            );
          },
        ),
      ),
    );
  }
}
