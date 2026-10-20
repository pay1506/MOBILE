
import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  IconData _iconForProduct(String name) {
    final productName = name.toLowerCase();

    if (productName.contains('laptop')) return Icons.laptop_mac;
    if (productName.contains('mouse')) return Icons.mouse;
    if (productName.contains('keyboard')) return Icons.keyboard;
    if (productName.contains('headset') ||
        productName.contains('speaker')) {
      return Icons.headphones;
    }
    if (productName.contains('smartphone') ||
        productName.contains('phone')) {
      return Icons.smartphone;
    }
    if (productName.contains('tablet')) {
      return Icons.tablet_android;
    }
    if (productName.contains('watch')) return Icons.watch;

    return Icons.devices_other;
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    final double finalPrice = product is DiscountedProduct
        ? product.hargaFinal
        : product.price;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto produk dari API
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(10),
                      child: product.imageUrl.isNotEmpty
                          ? Image.network(
                              product.imageUrl,
                              fit: BoxFit.contain,
                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) {
                                  return child;
                                }

                                return const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                );
                              },
                              errorBuilder: (
                                context,
                                error,
                                stackTrace,
                              ) {
                                return Icon(
                                  _iconForProduct(product.name),
                                  size: 60,
                                  color: Colors.blueGrey,
                                );
                              },
                            )
                          : Icon(
                              _iconForProduct(product.name),
                              size: 60,
                              color: Colors.blueGrey,
                            ),
                    ),
                  ),

                  // Tombol favorit
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton(
                      tooltip: 'Favorit',
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isFavorite
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ),
                  ),

                  // Label diskon
                  if (product is DiscountedProduct)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '-${product.discountPercent.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Informasi produk
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 4, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 4),

                    Expanded(
                      child: Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),

                    if (product is DiscountedProduct)
                      Text(
                        formatRupiah(product.price),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),

                    Text(
                      formatRupiah(finalPrice),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      product.getStatusStok(),
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 11,
                        color: product.stock <= 0
                            ? Colors.red
                            : product.stock <= 5
                                ? Colors.orange
                                : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
