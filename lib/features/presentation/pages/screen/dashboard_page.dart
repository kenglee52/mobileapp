import 'package:flutter/material.dart';
import 'package:mobileapp/core/components/slide_component.dart';
import 'package:mobileapp/features/presentation/pages/product_detail_page.dart';
import 'package:mobileapp/features/presentation/viewmodels/product_view_model.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productVM = context.watch<ProductViewModel>();
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text(
                    "ສິນຄ້າໂປຣໂມຊັນສຸດຄຸ້ມ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF424242),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const SlideComponent(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "ສິນຄ້າທີ່ມາແຮງ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF424242),
                ),
              ),
            ),

            const SizedBox(height: 12),
            Expanded(
              child:
                  productVM.isLoading
                      ? const Center(child: Text("ກຳລັງໂຫລດສິນຄ້າ..."))
                      : GridView.builder(
                        padding: const EdgeInsets.only(
                          bottom: 16,
                          left: 16,
                          right: 16,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 14,
                              childAspectRatio: 0.75,
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
                                        category: product.category.categoryName,
                                        unit: product.unit.unitName,
                                        image: product.image,
                                        price: product.price,
                                        stockQuatity: product.stockQty,
                                        decoration:
                                            product.description as String,
                                      ),)
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
    );
  }
}
