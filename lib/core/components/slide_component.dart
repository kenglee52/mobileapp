import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SlideComponent extends StatefulWidget {
  const SlideComponent({super.key});

  @override
  State<SlideComponent> createState() => _SlideComponentState();
}

class _SlideComponentState extends State<SlideComponent> {
  int _current = 0;

  final List<String> img = [
    "assets/images/picture1.jpg",
    "assets/images/picture2.jpg",
    "assets/images/picture3.jpg",
    "assets/images/picture4.jpg",
    "assets/images/picture5.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: img.map((item) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      item,
                      fit: BoxFit.fill,
                    ),
                    // Gradient Overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.45),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.2,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),

        const SizedBox(height: 10),

        // Indicator dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: img.asMap().entries.map((entry) {
            return Container(
              width: _current == entry.key ? 18 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _current == entry.key
                    ? Colors.orange.shade600
                    : Colors.grey.shade400,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
