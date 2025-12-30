import 'package:flutter/material.dart';
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
  int _seletedIndex = 0;
  List<Widget> screens = [DashboardPage(), ProductPage(), FavoritePage()];
  void tapMenu(int index) {
    setState(() {
      _seletedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.message)),
          PopupMenuButton(
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text("ອອກຈາກລະບົບ"),
                    ),
                  ),
                ],
          ),
        ],
        backgroundColor: Colors.grey.shade800,
        title: Text(
          "MyApp",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: screens[_seletedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade800,
        onPressed: () {},
        child: Icon(Icons.shopping_cart, color: Colors.white),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.amber.shade300,
          currentIndex: _seletedIndex,
          onTap: (value) {
            tapMenu(value);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "ໜ້າຫຼັກ"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "ສິນຄ້າ"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "ສົນໃຈ"),
          ],
        ),
      ),
    );
  }
}
