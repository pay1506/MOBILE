import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    print('initState: ${widget.product.name}');
  }

  @override
  Widget build(BuildContext context) {
    print('build: ${widget.product.name}');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Isi produk
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar produk
              const Icon(
                Icons.image,
                size: 80,
              ),

              const SizedBox(width: 12),

              // Informasi produk
              Expanded(
                child: Padding(
                  // Memberikan ruang agar tidak bertabrakan
                  // dengan badge status stok.
                  padding: const EdgeInsets.only(right: 90),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      CategoryTag(
                        category: widget.product.category,
                      ),

                      const SizedBox(height: 5),

                      Text(
                        formatRupiah(widget.product.price),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // =========================
          // BADGE DISKON
          // =========================
          if (widget.product is DiscountedProduct)
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Diskon ${(widget.product as DiscountedProduct).discountPercent.toStringAsFixed(0)}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // =========================
          // BADGE STATUS STOK
          // =========================
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: _getStockColor(widget.product.stock),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.product.getStatusStok(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // =========================
          // TOMBOL FAVORITE
          // =========================
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              icon: Icon(
                isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStockColor(int stock) {
    if (stock == 0) {
      return Colors.red;
    } else if (stock <= 5) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  @override
  void dispose() {
    print('dispose: ${widget.product.name}');
    super.dispose();
  }
}

// =========================
// CATEGORY TAG
// =========================

class CategoryTag extends StatelessWidget {
  final String category;

  const CategoryTag({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        category,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}