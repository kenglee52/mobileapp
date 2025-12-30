import 'package:flutter/material.dart';
import 'package:mobileapp/features/presentation/viewmodels/category_view_model.dart';
import 'package:mobileapp/features/presentation/viewmodels/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final categoryVM = context.watch<CategoryViewModel>();
    final productVM = context.watch<ProductViewModel>();
    final categories = [
      {"categoryName": "ທັງໝົດ"},
      ...categoryVM.category.map((e) => {"categoryName": e.categoryName}),
    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "ຄົ້ນຫາສິນຄ້າ",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "ປະເພດສິນຄ້າ",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 45,
              child:
                  categoryVM.isLoading
                      ? Center(
                        child: Text(
                          "ກຳລັງໂຫລດປະເພດ...",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                      : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final isSelected = selectedIndex == index;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(
                                categories[index]["categoryName"].toString(),
                                style: TextStyle(
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : Colors.grey.shade800,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              selected: isSelected,
                              selectedColor: Colors.grey.shade600,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              onSelected: (value) {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                            ),
                          );
                        },
                      ),
            ),
            SizedBox(height: 20),
            Text(
              "ສິນຄ້າທີ່ແນະນຳ",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child:
                  productVM.isLoading
                      ? Center(
                        child: Text(
                          "ກຳລັງໂຫລດສິນຄ້າ...",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                      : GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.70,
                            ),
                        itemCount: productVM.product.length,
                        itemBuilder: (context, index) {
                          final productItem = productVM.product[index];

                          return Card(
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ===== Image Section =====
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                      child: Image.network(
                                        productItem.image,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                            0.18,
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.favorite_border,
                                            color: Colors.redAccent,
                                            size: 22,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // ===== Info Section =====
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productItem.productName,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "${productItem.price} ກີບ",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
