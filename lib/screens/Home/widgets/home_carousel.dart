import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;
import '../controllers/home_controller.dart';

class HomeCarousel extends StatelessWidget {
  // It's better practice to expect the controller to be passed in.
  // This makes the widget more testable and reusable.
  final HomeController controller;

  const HomeCarousel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Obx wraps the entire part of the UI that depends on reactive variables.
    return Obx(
      () => Column(
        children: [
          cs.CarouselSlider(
            options: cs.CarouselOptions(
              height: 180,
              autoPlay: true,
              enlargeCenterPage: true,
              // Update the controller's state when the page changes.
              onPageChanged: (index, reason) =>
                  controller.updateCarouselIndex(index),
            ),
            items: controller.carouselImages.map((imagePath) {
              print(imagePath);
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        // ✨ IMPROVEMENT: Add an error builder for robustness.
                        // This shows a placeholder icon if an image fails to load,
                        // preventing the app from showing an ugly red cross.
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                              size: 40,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // Dots Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: controller.carouselImages.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // Use the reactive variable from the controller to build the UI.
                  color: controller.currentIndex.value == entry.key
                      ? Colors.purple
                      : Colors.grey.shade400,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
