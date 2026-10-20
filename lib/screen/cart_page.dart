import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../models/product.dart';
import 'checkout_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

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
    if (name.contains('smartphone')) return Icons.smartphone;
    if (name.contains('tablet')) return Icons.tablet_android;
    if (name.contains('smartwatch')) return Icons.watch;

    return Icons.devices_other;
  }

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        actions: [
          IconButton(
            tooltip: 'Kosongkan Keranjang',
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              if (controller.cartItems.isEmpty) {
                Get.snackbar(
                  'Keranjang Kosong',
                  'Tidak ada produk yang perlu dihapus.',
                );
                return;
              }

              Get.defaultDialog(
                title: 'Kosongkan Keranjang?',
                middleText:
                    'Semua produk di keranjang akan dihapus.',
                textCancel: 'Batal',
                textConfirm: 'Kosongkan',
                confirmTextColor: Colors.white,
                onConfirm: () {
                  Get.back();
                  controller.clearCart();

                  Get.snackbar(
                    'Berhasil',
                    'Keranjang berhasil dikosongkan.',
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 80,
                  color: Colors.grey,
                ),
                SizedBox(height: 12),
                Text(
                  'Keranjang masih kosong',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 6),
                Text('Silakan pilih produk di Beranda.'),
              ],
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  final product = controller.cartItems[index];
                  final quantity =
                      controller.quantities[product.id] ?? 1;

                  final double price = product is DiscountedProduct
                      ? product.hargaFinal
                      : product.price;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              _iconForProduct(product),
                              size: 30,
                              color: Colors.blueGrey,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(formatRupiah(price)),
                                Row(
                                  children: [
                                    IconButton(
                                      tooltip: 'Kurangi jumlah',
                                      onPressed: () {
                                        controller.decreaseQuantity(product);
                                      },
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                      ),
                                      padding: EdgeInsets.zero,
                                      constraints:
                                          const BoxConstraints(
                                        minWidth: 32,
                                        minHeight: 32,
                                      ),
                                    ),
                                    Text('$quantity'),
                                    IconButton(
                                      tooltip: 'Tambah jumlah',
                                      onPressed: () {
                                        controller.increaseQuantity(product);
                                      },
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                      ),
                                      padding: EdgeInsets.zero,
                                      constraints:
                                          const BoxConstraints(
                                        minWidth: 32,
                                        minHeight: 32,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formatRupiah(price * quantity),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                tooltip: 'Hapus produk',
                                onPressed: () {
                                  controller.removeFromCart(product);
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total item'),
                      Text(
                        '${controller.totalItem} barang',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Harga',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        formatRupiah(controller.totalHarga),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (controller.cartItems.isEmpty) {
                        Get.snackbar(
                          'Keranjang Kosong',
                          'Tambahkan produk sebelum checkout.',
                        );
                        return;
                      }

                      Get.off(() => CheckoutPage());
                    },
                    icon: const Icon(Icons.shopping_bag_outlined),
                    label: const Text('Checkout'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}