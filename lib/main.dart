import 'package:flutter/material.dart';

import 'models/product.dart';
import 'widgets/product_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TokoKita',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TokoKita'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: daftarProduk.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: daftarProduk[index],
          );
        },
      ),
    );
  }
}

final List<Product> daftarProduk = [
  Product(
    id: 1,
    name: 'Laptop ASUS',
    price: 7500000,
    imageUrl: 'laptop.jpg',
    category: 'Elektronik',
    stock: 5,
    description: 'Laptop untuk kebutuhan kuliah',
  ),
  Product(
    id: 2,
    name: 'Mouse Logitech',
    price: 250000,
    imageUrl: 'mouse.jpg',
    category: 'Elektronik',
    stock: 10,
    description: 'Mouse wireless untuk laptop',
  ),
  Product(
    id: 3,
    name: 'Keyboard Mechanical',
    price: 650000,
    imageUrl: 'keyboard.jpg',
    category: 'Elektronik',
    stock: 7,
    description: 'Keyboard mechanical untuk mengetik',
  ),
  Product(
    id: 4,
    name: 'Headset Gaming',
    price: 450000,
    imageUrl: 'headset.jpg',
    category: 'Elektronik',
    stock: 3,
    description: 'Headset untuk gaming dan meeting',
  ),
  Product(
    id: 5,
    name: 'Sepatu Sneakers',
    price: 500000,
    imageUrl: 'sepatu.jpg',
    category: 'Fashion',
    stock: 4,
    description: 'Sepatu sneakers casual',
  ),
  Product(
    id: 6,
    name: 'Hoodie',
    price: 300000,
    imageUrl: 'hoodie.jpg',
    category: 'Fashion',
    stock: 8,
    description: 'Hoodie nyaman untuk sehari-hari',
  ),
  Product(
    id: 7,
    name: 'Kaos Polos',
    price: 100000,
    imageUrl: 'kaos.jpg',
    category: 'Fashion',
    stock: 15,
    description: 'Kaos polos bahan cotton',
  ),
  Product(
    id: 8,
    name: 'Keripik Kentang',
    price: 25000,
    imageUrl: 'keripik.jpg',
    category: 'Makanan',
    stock: 20,
    description: 'Keripik kentang rasa original',
  ),
];