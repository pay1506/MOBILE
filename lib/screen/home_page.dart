import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../widgets/product_card.dart';
import 'cart_page.dart';
import 'product_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductService _productService = ProductService();

  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _productService.fetchProducts();
  }

  Future<void> _loadProducts() async {
    final future = _productService.fetchProducts();

    setState(() {
      _productsFuture = future;
    });

    try {
      await future;
    } catch (_) {
      // Pesan error ditampilkan melalui FutureBuilder.
    }
  }

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
            child: Text(
              'Laptop, smartphone, tablet, dan aksesori pilihan.',
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.wifi_off,
                            size: 48,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Gagal memuat produk. '
                            'Periksa koneksi internetmu.',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton.icon(
                            onPressed: _loadProducts,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Coba Lagi'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final products = snapshot.data ?? [];

                if (products.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Produk belum tersedia.'),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _loadProducts,
                          child: const Text('Coba Lagi'),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: _loadProducts,
                  child: GridView.builder(
                    physics:
                        const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(12),
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.66,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];

                      return ProductCard(
                        product: product,
                        onTap: () {
                          Get.to(
                            () => ProductDetailPage(
                              product: product,
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}