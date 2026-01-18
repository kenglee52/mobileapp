import 'package:flutter/material.dart';
import 'package:mobileapp/features/presentation/pages/cart_page.dart';
import 'package:mobileapp/features/presentation/pages/history_page.dart';
import 'package:mobileapp/features/presentation/pages/login_page.dart';
import 'package:mobileapp/features/presentation/pages/screen/dashboard_page.dart';
import 'package:mobileapp/features/presentation/pages/screen/favorite_page.dart';
import 'package:mobileapp/features/presentation/pages/screen/product_page.dart';

class HomePage extends StatefulWidget {
  final int userID;
  const HomePage({super.key, required this.userID});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> screens = const [
    DashboardPage(),
    ProductPage(),
    FavoritePage(),
  ];

  void tapMenu(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(62),
        child: AppBar(
          elevation: 4,
          backgroundColor: Color(0xFFD32F2F),
          title: const Text(
            "LAO SHOP",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              fontSize: 22,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.receipt_long, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoryPage(id: widget.userID),
                  ),
                );
              },
            ),
            PopupMenuButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              itemBuilder:
                  (context) => [
                    PopupMenuItem(
                      child: ListTile(
                        leading: const Icon(
                          Icons.logout,
                          color: Color(0xFFD32F2F),
                        ),
                        title: const Text("ອອກຈາກລະບົບ"),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
            ),
          ],
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: screens[_selectedIndex],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 8,
        backgroundColor: Color(0xFFD32F2F),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartPage(customerID: widget.userID),
            ),
          );
        },
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),

      /// ⬇ Bottom Navigation
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.15)),
          ],
        ),
        child: SizedBox(
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: _selectedIndex,
            onTap: tapMenu,
            selectedItemColor: Colors.orange.shade200,
            unselectedItemColor: Colors.white,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "ໜ້າຫຼັກ"),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt),
                label: "ສິນຄ້າ",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "ສົນໃຈ",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
