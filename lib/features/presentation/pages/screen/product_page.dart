import 'package:flutter/material.dart';
import 'package:mobileapp/features/presentation/pages/product_detail_page.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔍 Search
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade800),
                    hintText: "ຄົ້ນຫາສິນຄ້າ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade800),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// 🏷 Category
              const Text(
                "ປະເພດສິນຄ້າ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF424242),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 42,
                child:
                    categoryVM.isLoading
                        ? const Center(child: Text("ກຳລັງໂຫລດ..."))
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
                                selectedColor: Colors.orange.shade600,
                                backgroundColor: Colors.white,
                                elevation: isSelected ? 4 : 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                onSelected: (_) {
                                  setState(() => selectedIndex = index);
                                },
                              ),
                            );
                          },
                        ),
              ),

              const SizedBox(height: 24),

              /// 🛍 Products
              const Text(
                "ສິນຄ້າແນະນຳ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF424242),
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child:
                    productVM.isLoading
                        ? const Center(child: Text("ກຳລັງໂຫລດສິນຄ້າ..."))
                        : GridView.builder(
                          padding: const EdgeInsets.only(bottom: 16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 14,
                                childAspectRatio: 0.68,
                              ),
                          itemCount: productVM.product.length,
                          itemBuilder: (context, index) {
                            final product = productVM.product[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => ProductDetailPage(
                                          id: product.productID as int,
                                          name: product.productName,
                                          category:
                                              product.category.categoryName,
                                          unit: product.unit.unitName,
                                          image: product.image,
                                          price: product.price,
                                        ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// 🖼 Image
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                top: Radius.circular(18),
                                              ),
                                          child: Image.network(
                                            product.image,
                                            height:
                                                MediaQuery.sizeOf(
                                                  context,
                                                ).height *
                                                0.18,
                                            width: double.infinity,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Positioned(
                                          top: 10,
                                          right: 10,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.favorite_border,
                                                color: Colors.orange.shade600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    /// ℹ Info
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.productName,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF424242),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "${product.price} ກີບ",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
