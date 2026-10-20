import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'cart_page.dart';
import 'product_detail_page.dart';

final List<Product> daftarProduk = [
  Product(
    id: 1,
    name: 'Laptop Lenovo',
    price: 7500000,
    category: 'Laptop',
    stock: 10,
    description: 'Laptop untuk kuliah dan pekerjaan sehari-hari.',
  ),
  DiscountedProduct(
    id: 2,
    name: 'Mouse Wireless',
    price: 150000,
    category: 'Aksesori',
    stock: 20,
    discountPercent: 20,
  ),
  Product(
    id: 3,
    name: 'Keyboard Mechanical',
    price: 450000,
    category: 'Aksesori',
    stock: 8,
  ),
  DiscountedProduct(
    id: 4,
    name: 'Headset Gaming',
    price: 350000,
    category: 'Audio',
    stock: 5,
    discountPercent: 15,
  ),
  Product(
    id: 5,
    name: 'Monitor 24 Inch',
    price: 1800000,
    category: 'Monitor',
    stock: 7,
  ),
  Product(
    id: 6,
    name: 'Webcam HD',
    price: 250000,
    category: 'Aksesori',
    stock: 12,
  ),
  Product(
    id: 7,
    name: 'SSD 512GB',
    price: 650000,
    category: 'Penyimpanan',
    stock: 9,
  ),
  Product(
    id: 8,
    name: 'RAM 16GB',
    price: 550000,
    category: 'Komponen',
    stock: 6,
  ),
  Product(
    id: 9,
    name: 'Powerbank 20000mAh',
    price: 300000,
    category: 'Aksesori',
    stock: 15,
  ),
  Product(
    id: 10,
    name: 'Charger USB-C',
    price: 175000,
    category: 'Aksesori',
    stock: 18,
  ),
  Product(
    id: 11,
    name: 'USB Hub',
    price: 120000,
    category: 'Aksesori',
    stock: 10,
  ),
  Product(
    id: 12,
    name: 'Cooling Pad',
    price: 200000,
    category: 'Aksesori',
    stock: 4,
  ),
  Product(
    id: 13,
    name: 'Smartphone',
    price: 3200000,
    category: 'Gadget',
    stock: 8,
  ),
  Product(
    id: 14,
    name: 'Tablet Android',
    price: 2800000,
    category: 'Gadget',
    stock: 6,
  ),
  Product(
    id: 15,
    name: 'Smartwatch',
    price: 450000,
    category: 'Gadget',
    stock: 11,
  ),
  Product(
    id: 16,
    name: 'Mousepad Gaming',
    price: 85000,
    category: 'Aksesori',
    stock: 20,
  ),
  Product(
    id: 17,
    name: 'Speaker Bluetooth',
    price: 275000,
    category: 'Audio',
    stock: 7,
  ),
  Product(
    id: 18,
    name: 'Flashdisk 64GB',
    price: 90000,
    category: 'Penyimpanan',
    stock: 0,
  ),
  Product(
    id: 19,
    name: 'Kabel USB-C',
    price: 50000,
    category: 'Aksesori',
    stock: 25,
  ),
  Product(
    id: 20,
    name: 'Microphone USB',
    price: 400000,
    category: 'Audio',
    stock: 5,
  ),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TokoKita',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Obx(
            () => IconButton(
              tooltip: 'Keranjang',
              onPressed: () {
                Get.to(() => const CartPage());
              },
              icon: Badge(
                label: Text('${controller.totalItem}'),
                isLabelVisible: controller.totalItem > 0,
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text(
              'Temukan Produk Favoritmu',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Pilihan produk elektronik untuk kebutuhanmu.'),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: daftarProduk.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.66,
              ),
              itemBuilder: (context, index) {
                final product = daftarProduk[index];

                return ProductCard(
                  product: product,
                  onTap: () {
                    Get.to(
                      () => ProductDetailPage(product: product),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}