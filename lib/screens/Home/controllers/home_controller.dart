// import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:carousel_slider/carousel_slider.dart' as cs;
class HomeController extends GetxController {
  var currentIndex = 0.obs;

  List<String> carouselImages = [
    'assets/images/image-5.jpg',
    'assets/images/image-9.png',
    'assets/images/image-4.jpg',
  ];

  // final cs.CarouselController carouselController = cs.CarouselController();
  void updateCarouselIndex(int index) {
    print("Current carousel index: $index");
    currentIndex.value = index;
  }

  List<Map<String, dynamic>> games = [
    {'title': 'Poll Game', 'icon': 'poll'},
    {'title': 'Number League', 'icon': 'confirmation_num'},
    {'title': 'Color Prediction', 'icon': 'color_lens'},
    {'title': 'Betting Game', 'icon': 'sports_soccer'},
  ];
}
