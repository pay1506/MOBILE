import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int jumlah = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    final bool isDiscounted = product is DiscountedProduct;

    double hargaFinal = product.price;

    if (isDiscounted) {
      hargaFinal = product.hargaFinal;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar produk
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 250,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 60,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Nama produk
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // Kategori
            Text(
              product.category,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),

            const SizedBox(height: 16),

            // Harga
            if (isDiscounted) ...[
              Text(
                formatRupiah(product.price),
                style: const TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                formatRupiah(hargaFinal),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ] else
              Text(
                formatRupiah(product.price),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

            const SizedBox(height: 16),

            // Status stok
            const Text(
              'Status Stok',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              '${product.getStatusStok()} (${product.stock} tersedia)',
              style: const TextStyle(
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 20),

            // Deskripsi
            const Text(
              'Deskripsi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              product.description ??
                  'Belum ada deskripsi untuk produk ini.',
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 24),

            // Jumlah
            const Text(
              'Jumlah',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                // Tombol kurang
                IconButton(
                  onPressed: jumlah > 1
                      ? () {
                          setState(() {
                            jumlah--;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.remove),
                ),

                Container(
                  width: 50,
                  alignment: Alignment.center,
                  child: Text(
                    '$jumlah',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Tombol tambah
                IconButton(
                  onPressed: jumlah < product.stock
                      ? () {
                          setState(() {
                            jumlah++;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Tombol tambah ke keranjang
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: product.stock > 0
                    ? () {
                        Navigator.pop(context, jumlah);
                      }
                    : null,
                icon: const Icon(Icons.shopping_cart),
                label: const Text(
                  'Tambah ke Keranjang',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}