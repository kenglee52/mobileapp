import 'package:flutter/material.dart';
import 'package:mobileapp/features/presentation/pages/cart_page.dart';
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
      backgroundColor: Colors.grey.shade100,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(62),
        child: AppBar(
          elevation: 4,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.shade900, Colors.grey.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "MyApp",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              fontSize: 22,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.message, color: Colors.white),
              onPressed: () {},
            ),
            PopupMenuButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              itemBuilder:
                  (context) => [
                    PopupMenuItem(
                      child: ListTile(
                        leading: const Icon(
                          Icons.logout,
                          color: Colors.redAccent,
                        ),
                        title: const Text("ອອກຈາກລະບົບ"),
                        onTap: () {},
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

      /// 🛒 Floating Cart
      floatingActionButton: FloatingActionButton(
        elevation: 8,
        backgroundColor: Colors.grey.shade800,
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
          gradient: LinearGradient(
            colors: [Colors.grey.shade900, Colors.grey.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.25)),
          ],
        ),
        child: SizedBox(
          height: 60,
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: _selectedIndex,
            onTap: tapMenu,
            selectedItemColor: Colors.orange.shade300,
            unselectedItemColor: Colors.white70,
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
