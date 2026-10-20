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

  factory Product.fromJson(Map<String, dynamic> json) {
    // Harga dari DummyJSON berupa USD.
    // Konversi perkiraan ke rupiah untuk tampilan aplikasi.
    const kurs = 16000.0;

    return Product(
      id: (json['id'] as num).toInt(),
      name: (json['title'] ?? json['name'] ?? 'Produk').toString(),
      price: (json['price'] as num).toDouble() * kurs,
      imageUrl: (
        json['thumbnail'] ??
        json['image'] ??
        json['imageUrl'] ??
        ''
      ).toString(),
      category: (json['category'] ?? 'Lainnya').toString(),
      stock: json['stock'] is num
          ? (json['stock'] as num).toInt()
          : 10,
      description: json['description']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    const kurs = 16000.0;

    return {
      'id': id,
      'title': name,
      'price': price / kurs,
      'thumbnail': imageUrl,
      'category': category,
      'stock': stock,
      'description': description,
    };
  }

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