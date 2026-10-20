import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../models/product.dart';

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

  IconData _iconForProduct() {
    final name = widget.product.name.toLowerCase();

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
    if (name.contains('smartphone')) return Icons.smartphone;
    if (name.contains('tablet')) return Icons.tablet_android;
    if (name.contains('smartwatch')) return Icons.watch;

    return Icons.devices_other;
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final CartController controller = Get.find<CartController>();

    final double price = product is DiscountedProduct
        ? product.hargaFinal
        : product.price;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Detail Produk'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              _iconForProduct(),
              size: 100,
              color: Colors.blueGrey,
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
          const SizedBox(height: 8),
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
          ],
          Text(
            formatRupiah(price),
            style: const TextStyle(
              fontSize: 22,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text('Status stok: ${product.getStatusStok()}'),
          const SizedBox(height: 12),
          Text(
            product.description ?? 'Tidak ada deskripsi produk.',
          ),
          const SizedBox(height: 24),
          const Text(
            'Jumlah',
            style: TextStyle(fontWeight: FontWeight.bold),
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
              Text(
                formatRupiah(price * jumlah),
                style: const TextStyle(fontWeight: FontWeight.bold),
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
      ),
    );
  }
}