import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/product_card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Product> daftarProduk = [
    Product(
      id: 1,
      name: 'Laptop Lenovo',
      price: 7500000,
      imageUrl: 'https://picsum.photos/200?random=200',
      category: 'Laptop',
      stock: 10,
    ),
    DiscountedProduct(
      id: 2,
      name: 'Mouse Wireless',
      price: 250000,
      imageUrl: 'https://picsum.photos/200?random=201',
      category: 'Aksesoris',
      stock: 8,
      discountPercent: 20,
    ),
    Product(
      id: 3,
      name: 'Keyboard Mechanical',
      price: 850000,
      imageUrl: 'https://picsum.photos/200?random=202',
      category: 'Aksesoris',
      stock: 5,
    ),
    DiscountedProduct(
      id: 4,
      name: 'Headset Gaming',
      price: 450000,
      imageUrl: 'https://picsum.photos/200?random=203',
      category: 'Aksesoris',
      stock: 12,
      discountPercent: 15,
    ),
    Product(
      id: 5,
      name: 'Monitor 24 Inch',
      price: 1800000,
      imageUrl: 'https://picsum.photos/200?random=204',
      category: 'Monitor',
      stock: 6,
    ),
    Product(
      id: 6,
      name: 'Webcam Full HD',
      price: 550000,
      imageUrl: 'https://picsum.photos/200?random=205',
      category: 'Aksesoris',
      stock: 7,
    ),
    Product(
      id: 7,
      name: 'SSD 512GB',
      price: 700000,
      imageUrl: 'https://picsum.photos/200?random=206',
      category: 'Storage',
      stock: 9,
    ),
    Product(
      id: 8,
      name: 'RAM 16GB',
      price: 650000,
      imageUrl: 'https://picsum.photos/200?random=207',
      category: 'Komponen',
      stock: 4,
    ),
    Product(
      id: 9,
      name: 'Flashdisk 64GB',
      price: 120000,
      imageUrl: 'https://picsum.photos/200?random=208',
      category: 'Storage',
      stock: 15,
    ),
    Product(
      id: 10,
      name: 'Powerbank 20000mAh',
      price: 350000,
      imageUrl: 'https://picsum.photos/200?random=209',
      category: 'Aksesoris',
      stock: 3,
    ),
    Product(
      id: 11,
      name: 'USB Hub',
      price: 150000,
      imageUrl: 'https://picsum.photos/200?random=210',
      category: 'Aksesoris',
      stock: 11,
    ),
    Product(
      id: 12,
      name: 'Cooling Pad',
      price: 200000,
      imageUrl: 'https://picsum.photos/200?random=211',
      category: 'Aksesoris',
      stock: 2,
    ),
    Product(
      id: 13,
      name: 'Kabel HDMI',
      price: 80000,
      imageUrl: 'https://picsum.photos/200?random=212',
      category: 'Kabel',
      stock: 20,
    ),
    Product(
      id: 14,
      name: 'Speaker Bluetooth',
      price: 300000,
      imageUrl: 'https://picsum.photos/200?random=213',
      category: 'Audio',
      stock: 6,
    ),
    Product(
      id: 15,
      name: 'Smartphone',
      price: 4500000,
      imageUrl: 'https://picsum.photos/200?random=214',
      category: 'Smartphone',
      stock: 5,
    ),
    Product(
      id: 16,
      name: 'Tablet Android',
      price: 3200000,
      imageUrl: 'https://picsum.photos/200?random=215',
      category: 'Tablet',
      stock: 7,
    ),
    Product(
      id: 17,
      name: 'Smartwatch',
      price: 850000,
      imageUrl: 'https://picsum.photos/200?random=216',
      category: 'Wearable',
      stock: 6,
    ),
    Product(
      id: 18,
      name: 'Microphone USB',
      price: 600000,
      imageUrl: 'https://picsum.photos/200?random=217',
      category: 'Audio',
      stock: 4,
    ),
    Product(
      id: 19,
      name: 'Mousepad Gaming',
      price: 150000,
      imageUrl: 'https://picsum.photos/200?random=218',
      category: 'Aksesoris',
      stock: 10,
    ),
    Product(
      id: 20,
      name: 'Charger USB-C',
      price: 180000,
      imageUrl: 'https://picsum.photos/200?random=219',
      category: 'Aksesoris',
      stock: 8,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TokoKita'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Temukan produk favoritmu',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                  ),
                ),
              ],
            ),
          ),

          // Daftar produk
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              itemCount: daftarProduk.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: daftarProduk[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}