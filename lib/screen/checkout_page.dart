import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../models/product.dart';
import 'main_page.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({super.key});

  final CartController controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        final items = controller.cartItems.toList();

        if (items.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.shopping_cart_outlined,
                  size: 72,
                  color: Colors.grey,
                ),
                const SizedBox(height: 12),
                const Text('Tidak ada pesanan untuk diproses.'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Get.off(() => const MainPage());
                  },
                  child: const Text('Kembali ke Beranda'),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Ringkasan Pesanan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final Product product = items[index];
                  final quantity =
                      controller.quantities[product.id] ?? 1;

                  final double price = product is DiscountedProduct
                      ? product.hargaFinal
                      : product.price;

                  return Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.shopping_bag_outlined,
                        size: 32,
                      ),
                      title: Text(product.name),
                      subtitle: Text(
                        '${formatRupiah(price)} x $quantity',
                      ),
                      trailing: Text(
                        formatRupiah(price * quantity),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Jumlah barang'),
                      Text('${controller.totalItem} barang'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Pembayaran',
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
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Get.defaultDialog(
                        title: 'Konfirmasi Pesanan',
                        middleText:
                            'Selesaikan pesanan dan kosongkan keranjang?',
                        textCancel: 'Batal',
                        textConfirm: 'Ya, Selesaikan',
                        confirmTextColor: Colors.white,
                        onConfirm: () {
                    Get.back(); // Menutup dialog konfirmasi
                    controller.clearCart();

                    Get.off(() => const MainPage());

                    Get.snackbar(
                        'Pesanan Berhasil',
                        'Terima kasih sudah berbelanja di TokoKita!',
                    );
                    },
                      );
                    },
                    child: const Text('Selesaikan Pesanan'),
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