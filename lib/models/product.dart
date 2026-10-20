class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  final int stock;
  final String? description;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl = '',
    required this.category,
    required this.stock,
    this.description,
  });

  String getInfo() {
    return '$name - ${formatRupiah(price)} - Stok: $stock';
  }

  String getStatusStok() {
    if (stock <= 0) return 'Habis';
    if (stock <= 5) return 'Stok Terbatas';
    return 'Tersedia';
  }
}

class DiscountedProduct extends Product {
  final double discountPercent;

  const DiscountedProduct({
    required super.id,
    required super.name,
    required super.price,
    super.imageUrl = '',
    required super.category,
    required super.stock,
    super.description,
    required this.discountPercent,
  });

  double get hargaFinal => price - (price * discountPercent / 100);
}

String formatRupiah(double harga) {
  final rounded = harga.round().toString();

  final formatted = rounded.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => '.',
  );

  return 'Rp $formatted';
}

double hitungTotalBelanja(List<Product> keranjang) {
  double total = 0;

  for (final produk in keranjang) {
    if (produk is DiscountedProduct) {
      total += produk.hargaFinal;
    } else {
      total += produk.price;
    }
  }

  return total;
}