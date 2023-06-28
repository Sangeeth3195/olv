import 'package:flutter/material.dart';
import 'package:omaliving/models/Product_detail.dart';

class Product {
  final String image, title;
  final int price;
  final Color bgColor;

  Product({
    required this.image,
    required this.title,
    required this.price,
    this.bgColor = const Color(0xFFEFEEEC),
  });
}


List<ProductDetail> demo_product = [
  ProductDetail(
    id: 1,
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    colors: [
      const Color(0xFFF4F2EE),
      const Color(0xFFF4F2EE),
      const Color(0xFFF4F2EE),
      Colors.white,
    ],
    title: "Wireless Controller for PS4™",
    price: 64.99,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  ProductDetail(
    id: 2,
    images: [
      "assets/images/Image Popular Product 2.png",
    ],
    colors: [
      const Color(0xFFF4F2EE),
      const Color(0xFF836DB8),
      const Color(0xFFF4F2EE),
      Colors.white,
    ],
    title: "Nike Sport White - Man Pant",
    price: 50.5,
    description: description,
    rating: 4.1,
    isPopular: true,
  ),
  ProductDetail(
    id: 3,
    images: [
      "assets/images/glap.png",
    ],
    colors: [
      const Color(0xFFF4F2EE),
      const Color(0xFF836DB8),
      const Color(0xFFF4F2EE),
      Colors.white,
    ],
    title: "Gloves XC Omega - Polygon",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  ProductDetail(
    id: 4,
    images: [
      "assets/images/wireless headset.png",
    ],
    colors: [
      const Color(0xFFF4F2EE),
      const Color(0xFF836DB8),
      const Color(0xFFF4F2EE),
      Colors.white,
    ],
    title: "Logitech Head",
    price: 20.20,
    description: description,
    rating: 4.1,
    isFavourite: true,
  ),
  ProductDetail(
    id: 5,
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    colors: [
      const Color(0xFFF4F2EE),
      const Color(0xFFF4F2EE),
      const Color(0xFFF4F2EE),
      Colors.white,
    ],
    title: "Wireless Controller for PS4™",
    price: 64.99,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  ProductDetail(
    id: 6,
    images: [
      "assets/images/Image Popular Product 2.png",
    ],
    colors: [
      const Color(0xFFF4F2EE),
      const Color(0xFF836DB8),
      const Color(0xFFF4F2EE),
      Colors.white,
    ],
    title: "Nike Sport White - Man Pant",
    price: 50.5,
    description: description,
    rating: 4.1,
    isPopular: true,
  ),
  ProductDetail(
    id: 7,
    images: [
      "assets/images/glap.png",
    ],
    colors: [
      const Color(0xFFF4F2EE),
      const Color(0xFF836DB8),
      const Color(0xFFF4F2EE),
      Colors.white,
    ],
    title: "Gloves XC Omega - Polygon",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  ProductDetail(
    id: 8,
    images: [
      "assets/images/wireless headset.png",
    ],
    colors: [
      const Color(0xFFF4F2EE),
      const Color(0xFF836DB8),
      const Color(0xFFF4F2EE),
      Colors.white,
    ],
    title: "Logitech Head",
    price: 20.20,
    description: description,
    rating: 4.1,
    isFavourite: true,
  ),
];

/*List<ProductDetail> demo_product = [
  Product(
    image: "assets/images/product_0.png",
    title: "Long Sleeve Shirts",
    price: 165,
    bgColor: const Color(0xFFEFEEEC),
  ),
  Product(
    image: "assets/images/product_1.png",
    title: "Casual Henley Shirts",
    price: 99,
  ),
  Product(
    image: "assets/images/product_2.png",
    title: "Curved Hem Shirts",
    price: 180,
    bgColor: const Color(0xFFEFEEEC),
  ),
  Product(
    image: "assets/images/product_3.png",
    title: "Casual Nolin",
    price: 149,
    bgColor: const Color(0xFFEFEEEC),
  ),  Product(
    image: "assets/images/product_3.png",
    title: "Casual Nolin",
    price: 149,
    bgColor: const Color(0xFFEFEEEC),
  ),  Product(
    image: "assets/images/product_3.png",
    title: "Casual Nolin",
    price: 149,
    bgColor: const Color(0xFFEFEEEC),
  ),
];*/
