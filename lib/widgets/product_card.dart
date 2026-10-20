import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

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
    if (name.contains('charger') || name.contains('powerbank')) {
      return Icons.battery_charging_full;
    }
    if (name.contains('kabel') || name.contains('usb hub')) {
      return Icons.usb;
    }
    if (name.contains('cooling pad')) return Icons.air;
    if (name.contains('smartphone')) return Icons.smartphone;
    if (name.contains('tablet')) return Icons.tablet_android;
    if (name.contains('smartwatch')) return Icons.watch;
    if (name.contains('mousepad')) return Icons.sports_esports;

    return Icons.devices_other;
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    final double price = product is DiscountedProduct
        ? product.hargaFinal
        : product.price;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: InkWell(
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.blueGrey.shade50,
                    child: Icon(
                      _iconForProduct(),
                      size: 64,
                      color: Colors.blueGrey,
                    ),
                  ),
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
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                  if (product is DiscountedProduct)
                    Positioned(
                      top: 8,
                      left: 8,
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
                          'Diskon ${product.discountPercent.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
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
                    formatRupiah(price),
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.getStatusStok(),
                    style: TextStyle(
                      fontSize: 12,
                      color: product.stock == 0
                          ? Colors.red
                          : product.stock <= 5
                              ? Colors.orange
                              : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}