void main() {
  // var
  var namaProduk = 'Laptop';
  namaProduk = 'Mouse';

  // final
  final hargaProduk = 5000000;

  // const
  const namaToko = 'TokoKita';

  print('Nama toko: $namaToko');
  print('Nama produk: $namaProduk');
  print('Harga produk: $hargaProduk');

  // Tipe data
  int stok = 10;
  double harga = 2500000.0;
  String nama = 'Laptop ASUS';
  bool tersedia = true;

  print('Stok: $stok');
  print('Harga: $harga');
  print('Nama: $nama');
  print('Tersedia: $tersedia');

  // List
  List<String> kategori = [
    'Elektronik',
    'Fashion',
    'Makanan',
  ];

  print('Kategori: $kategori');

  // Map
  Map<String, dynamic> produkMentah = {
    'id': 1,
    'name': 'Laptop ASUS',
    'price': 7500000,
    'stock': 5,
    'category': 'Elektronik',
  };

  print('Data produk: $produkMentah');

  latihanOperator();
  latihanFor();
  latihanWhile();

  print(
    'Harga setelah diskon: '
        '${hitungHargaSetelahDiskon(
      harga: 100000,
      persenDiskon: 10,
    )}',
  );

  print(
    'Harga tanpa diskon: '
        '${hitungHargaSetelahDiskon(
      harga: 100000,
    )}',
  );

  print(formatRupiah(150000));
  print('Diskon Elektronik: ${diskonKategori('Elektronik')}%');
  print('Diskon Fashion: ${diskonKategori('Fashion')}%');
  print('Diskon Makanan: ${diskonKategori('Makanan')}%');

  print(statusProduk(10));
  print(statusProduk(3));
  print(statusProduk(0));

  latihanClass();

  print(
    'Total keranjang: ${formatRupiah(
      hitungTotalBelanja([
        daftarProduk[0],
        daftarProduk[1],
        daftarProduk[4],
      ]),
    )}',
  );
}

String statusProduk(int stok) {
  if (stok == 0) {
    return 'Habis';
  } else if (stok <= 5) {
    return 'Stok Terbatas';
  } else {
    return 'Tersedia';
  }
}

void latihanOperator() {
  int harga = 50000;
  int jumlah = 3;
  int stok = 10;
  int pembelian = 4;

  // Operator aritmatika
  int totalHarga = harga * jumlah;
  int hargaTambah = harga + 10000;
  int hargaKurang = harga - 5000;
  double hargaBagi = harga / 2;
  int sisaStok = stok - pembelian;
  int sisaPembagian = stok % 3;

  print('Total harga: $totalHarga');
  print('Harga +: $hargaTambah');
  print('Harga -: $hargaKurang');
  print('Harga /: $hargaBagi');
  print('Sisa stok: $sisaStok');
  print('Sisa pembagian: $sisaPembagian');

  // Operator perbandingan
  int hargaProdukA = 50000;
  int hargaProdukB = 75000;

  print('Harga sama: ${hargaProdukA == hargaProdukB}');
  print('Harga berbeda: ${hargaProdukA != hargaProdukB}');
  print('A > B: ${hargaProdukA > hargaProdukB}');
  print('A < B: ${hargaProdukA < hargaProdukB}');
  print('A >= B: ${hargaProdukA >= hargaProdukB}');
  print('A <= B: ${hargaProdukA <= hargaProdukB}');

  // Operator logika
  int stokProduk = 5;
  double hargaProduk = 100000;

  bool layakDitampilkan =
      stokProduk > 0 && hargaProduk > 0;

  bool promo =
      stokProduk > 0 || hargaProduk < 50000;

  bool tidakHabis = !(stokProduk == 0);

  print('Layak ditampilkan: $layakDitampilkan');
  print('Promo: $promo');
  print('Tidak habis: $tidakHabis');
}

void latihanFor() {
  List<double> hargaProduk = [
    10000,
    20000,
    30000,
    40000,
  ];

  double totalBelanja = 0;

  for (double harga in hargaProduk) {
    totalBelanja += harga;
  }

  print('Total belanja: $totalBelanja');
}

void latihanWhile() {
  int stok = 5;

  while (stok > 0) {
    print('Stok sebelum pembelian: $stok');
    stok--;
  }

  print('Stok habis');
}

double diskonKategori(String kategori) {
  switch (kategori) {
    case 'Elektronik':
      return 10;
    case 'Fashion':
      return 15;
    case 'Makanan':
      return 5;
    default:
      return 0;
  }
}

double hitungHargaSetelahDiskon({
  required double harga,
  double persenDiskon = 0,
}) {
  return harga - (harga * persenDiskon / 100);
}

String formatRupiah(double harga) =>
    'Rp ${harga.toStringAsFixed(0)}';


List<Product> daftarProduk = [
  Product(
    id: 1,
    name: 'Laptop ASUS',
    price: 7500000,
    imageUrl: 'laptop.jpg',
    category: 'Elektronik',
    stock: 5,
    description: 'Laptop untuk kebutuhan kuliah',
  ),

  Product(
    id: 2,
    name: 'Mouse Logitech',
    price: 250000,
    imageUrl: 'mouse.jpg',
    category: 'Elektronik',
    stock: 10,
    description: 'Mouse wireless untuk laptop',
  ),

  Product(
    id: 3,
    name: 'Keyboard Mechanical',
    price: 650000,
    imageUrl: 'keyboard.jpg',
    category: 'Elektronik',
    stock: 7,
    description: 'Keyboard mechanical untuk mengetik',
  ),

  Product(
    id: 4,
    name: 'Headset Gaming',
    price: 450000,
    imageUrl: 'headset.jpg',
    category: 'Elektronik',
    stock: 3,
    description: 'Headset untuk gaming dan meeting',
  ),

  Product(
    id: 5,
    name: 'Sepatu Sneakers',
    price: 500000,
    imageUrl: 'sepatu.jpg',
    category: 'Fashion',
    stock: 4,
    description: 'Sepatu sneakers casual',
  ),

  Product(
    id: 6,
    name: 'Hoodie',
    price: 300000,
    imageUrl: 'hoodie.jpg',
    category: 'Fashion',
    stock: 8,
    description: 'Hoodie nyaman untuk sehari-hari',
  ),

  Product(
    id: 7,
    name: 'Kaos Polos',
    price: 100000,
    imageUrl: 'kaos.jpg',
    category: 'Fashion',
    stock: 15,
    description: 'Kaos polos bahan cotton',
  ),

  Product(
    id: 8,
    name: 'Keripik Kentang',
    price: 25000,
    imageUrl: 'keripik.jpg',
    category: 'Makanan',
    stock: 20,
    description: 'Keripik kentang rasa original',
  ),
];

double hitungTotalBelanja(List<Product> keranjang) {
  double total = 0;

  for (Product produk in keranjang) {
    total += produk.price;
  }

  return total;
}

void latihanClass() {
  Product laptop = Product(
    id: 1,
    name: 'Laptop ASUS',
    price: 7500000,
    imageUrl: 'laptop.jpg',
    category: 'Elektronik',
    stock: 5,
    description: 'Laptop untuk kebutuhan kuliah',
  );

  Product mouse = Product(
    id: 2,
    name: 'Mouse Logitech',
    price: 250000,
    imageUrl: 'mouse.jpg',
    category: 'Elektronik',
    stock: 10,
  );

  print(laptop.getInfo());
  print('Status laptop: ${laptop.getStatusStok()}');

  print(mouse.getInfo());
  print('Status mouse: ${mouse.getStatusStok()}');

  print('Daftar 8 Produk:');

  for (Product produk in daftarProduk) {
    print(
      '${produk.id}. ${produk.name} - '
          '${formatRupiah(produk.price)} - '
          'Stok: ${produk.stock}',
    );
  }

  DiscountedProduct sepatu = DiscountedProduct(
    id: 3,
    name: 'Sepatu Sneakers',
    price: 500000,
    imageUrl: 'sepatu.jpg',
    category: 'Fashion',
    stock: 3,
    description: 'Sepatu sneakers casual',
    discountPercent: 15,
  );

  print('Produk diskon: ${sepatu.name}');
  print('Harga normal: ${formatRupiah(sepatu.price)}');
  print('Diskon: ${sepatu.discountPercent}%');
  print('Harga final: ${formatRupiah(sepatu.hargaFinal)}');
}