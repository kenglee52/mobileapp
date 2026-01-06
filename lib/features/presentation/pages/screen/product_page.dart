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
  TextEditingController searchController = TextEditingController();
  int selectedIndex = 0;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryVM = context.watch<CategoryViewModel>();
    final productVM = context.watch<ProductViewModel>();
    final categories = [
      {"categoryName": "ທັງໝົດ"},
      ...categoryVM.category.map((e) => {"categoryName": e.categoryName}),
    ];

    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
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
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFD32F2F).withOpacity(0.1),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    final categoryName = selectedIndex == 0
                        ? "ທັງໝົດ"
                        : categoryVM.category[selectedIndex - 1].categoryName;
                    context.read<ProductViewModel>().searchProducts(
                          value,
                          categoryFilter: categoryName,
                        );
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Color(0xFFD32F2F)),
                    hintText: "ຄົ້ນຫາສິນຄ້າ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
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
                                            : Color(0xFF424242),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                selected: isSelected,
                                selectedColor: Color(0xFFD32F2F),
                                backgroundColor: Colors.white,
                                elevation: isSelected ? 4 : 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    color: Color(0xFFD32F2F).withOpacity(0.3),
                                  ),
                                ),
                                onSelected: (_) {
                                  setState(() => selectedIndex = index);
                                  final categoryName = index == 0
                                      ? "ທັງໝົດ"
                                      : categoryVM.category[index - 1].categoryName;
                                  context.read<ProductViewModel>().filterByCategory(
                                        categoryName,
                                      );
                                },
                              ),
                            );
                          },
                        ),
              ),
              const SizedBox(height: 24),
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
                        : productVM.filteredProducts.isEmpty
                            ? const Center(
                                child: Text("ບໍ່ມີສິນຄ້າທີ່ຕົງກັນ"))
                            : GridView.builder(
                              padding: const EdgeInsets.only(bottom: 16),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 14,
                                    childAspectRatio: 0.75,
                                  ),
                              itemCount: productVM.filteredProducts.length,
                              itemBuilder: (context, index) {
                                final product = productVM.filteredProducts[index];

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
                                          stockQuatity: product.stockQty,
                                          decoration: product.description as String,
                                          categoryID: product.categoryID,
                                          unitID: product.unitID,
                                          importPrice: product.importPrice,
                                          manufacture: product.manufature ?? "",
                                          expiry: product.expiry ?? "",
                                          description: product.description ?? "",
                                        ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// 🖼 Image
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                top: Radius.circular(12),
                                              ),
                                          child: Image.network(
                                            product.image,
                                            height:
                                                MediaQuery.sizeOf(
                                                  context,
                                                ).height *
                                                0.16,
                                            width: double.infinity,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Positioned(
                                          top: 10,
                                          right: 10,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 20,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.favorite_border,
                                                color: Color(0xFFD32F2F),
                                                size: 22,
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
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFD32F2F),
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
