
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailPage> createState() =>
      _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int jumlah = 1;

  final ProductService _productService = ProductService();
  late Future<Product> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture =
        _productService.fetchProductDetail(widget.product.id);
  }

  Future<void> _loadProduct() async {
    final future =
        _productService.fetchProductDetail(widget.product.id);

    setState(() {
      _productFuture = future;
    });

    try {
      await future;
    } catch (_) {
      // Error ditampilkan oleh FutureBuilder.
    }
  }

  IconData _iconForProduct(Product product) {
    final name = product.name.toLowerCase();

    if (name.contains('laptop')) return Icons.laptop_mac;
    if (name.contains('mouse')) return Icons.mouse;
    if (name.contains('keyboard')) return Icons.keyboard;
    if (name.contains('headset') || name.contains('speaker')) {
      return Icons.headphones;
    }
    if (name.contains('monitor')) return Icons.monitor;
    if (name.contains('webcam')) return Icons.videocam;
    if (name.contains('ssd') || name.contains('flashdisk')) {
      return Icons.storage;
    }
    if (name.contains('ram')) return Icons.memory;
    if (name.contains('smartphone') || name.contains('phone')) {
      return Icons.smartphone;
    }
    if (name.contains('tablet')) return Icons.tablet_android;
    if (name.contains('smartwatch') || name.contains('watch')) {
      return Icons.watch;
    }

    return Icons.devices_other;
  }

  Widget _buildProductDetail(Product product) {
    final CartController controller =
        Get.find<CartController>();

    final double price = product is DiscountedProduct
        ? product.hargaFinal
        : product.price;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Foto produk asli dari API
        Container(
          height: 260,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: product.imageUrl.isNotEmpty
              ? Image.network(
                  product.imageUrl,
                  fit: BoxFit.contain,
                  loadingBuilder:
                      (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        _iconForProduct(product),
                        size: 100,
                        color: Colors.blueGrey,
                      ),
                    );
                  },
                )
              : Center(
                  child: Icon(
                    _iconForProduct(product),
                    size: 100,
                    color: Colors.blueGrey,
                  ),
                ),
        ),

        const SizedBox(height: 20),

        Text(
          product.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text('Kategori: ${product.category}'),

        const SizedBox(height: 12),

        if (product is DiscountedProduct) ...[
          Text(
            formatRupiah(product.price),
            style: const TextStyle(
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          Text(
            'Diskon ${product.discountPercent.toStringAsFixed(0)}%',
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
        ],

        Text(
          formatRupiah(price),
          style: const TextStyle(
            fontSize: 24,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        Text('Status stok: ${product.getStatusStok()}'),
        Text('Jumlah stok: ${product.stock}'),

        const SizedBox(height: 12),

        Text(
          product.description ?? 'Tidak ada deskripsi produk.',
          style: const TextStyle(fontSize: 14),
        ),

        const SizedBox(height: 24),

        const Text(
          'Jumlah',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        Row(
          children: [
            IconButton(
              onPressed: () {
                if (jumlah > 1) {
                  setState(() => jumlah--);
                }
              },
              icon: const Icon(Icons.remove_circle_outline),
            ),

            Text(
              '$jumlah',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            IconButton(
              onPressed: () {
                if (jumlah < product.stock) {
                  setState(() => jumlah++);
                } else {
                  Get.snackbar(
                    'Stok Terbatas',
                    'Jumlah tidak boleh melebihi stok.',
                  );
                }
              },
              icon: const Icon(Icons.add_circle_outline),
            ),

            const Spacer(),

            Flexible(
              child: Text(
                formatRupiah(price * jumlah),
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        ElevatedButton.icon(
          onPressed: product.stock <= 0
              ? null
              : () {
                  final berhasil = controller.addToCart(
                    product,
                    quantity: jumlah,
                  );

                  if (berhasil) {
                    Get.back();
                  }
                },
          icon: const Icon(Icons.add_shopping_cart),
          label: const Text('Tambah ke Keranjang'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Detail Produk'),
      ),
      body: FutureBuilder<Product>(
        future: _productFuture,
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
                      'Gagal memuat detail produk.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _loadProduct,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          final product = snapshot.data;

          if (product == null) {
            return const Center(
              child: Text('Detail produk tidak tersedia.'),
            );
          }

          return _buildProductDetail(product);
        },
      ),
    );
  }
}
