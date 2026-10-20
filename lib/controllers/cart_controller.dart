import 'package:get/get.dart';
import '../models/product.dart';

class CartController extends GetxController {
  final RxList<Product> cartItems = <Product>[].obs;
  final RxMap<int, int> quantities = <int, int>{}.obs;

  int get totalItem {
    return quantities.values.fold(0, (total, qty) => total + qty);
  }

  double get totalHarga {
    double total = 0;

    for (final product in cartItems) {
      final quantity = quantities[product.id] ?? 1;

      final price = product is DiscountedProduct
          ? product.hargaFinal
          : product.price;

      total += price * quantity;
    }

    return total;
  }

  bool addToCart(Product product, {int quantity = 1}) {
    if (quantity <= 0) return false;

    if (product.stock <= 0) {
      Get.snackbar('Stok Habis', '${product.name} tidak tersedia.');
      return false;
    }

    final index = cartItems.indexWhere(
      (item) => item.id == product.id,
    );

    final currentQuantity =
        index == -1 ? 0 : (quantities[product.id] ?? 0);

    if (currentQuantity + quantity > product.stock) {
      Get.snackbar(
        'Stok Terbatas',
        'Stok ${product.name} hanya ${product.stock} barang.',
      );
      return false;
    }

    if (index == -1) {
      cartItems.add(product);
    }

    quantities[product.id] = currentQuantity + quantity;
    quantities.refresh();

    Get.snackbar(
      'Berhasil',
      '${product.name} ditambahkan ke keranjang.',
    );

    return true;
  }

  void increaseQuantity(Product product) {
    final currentQuantity = quantities[product.id] ?? 1;

    if (currentQuantity < product.stock) {
      quantities[product.id] = currentQuantity + 1;
      quantities.refresh();
    } else {
      Get.snackbar(
        'Stok Terbatas',
        'Jumlah produk sudah mencapai batas stok.',
      );
    }
  }

  void decreaseQuantity(Product product) {
    final currentQuantity = quantities[product.id] ?? 1;

    if (currentQuantity > 1) {
      quantities[product.id] = currentQuantity - 1;
      quantities.refresh();
    } else {
      removeFromCart(product);
    }
  }

  void removeFromCart(Product product) {
    cartItems.removeWhere((item) => item.id == product.id);
    quantities.remove(product.id);
  }

  void clearCart() {
    cartItems.clear();
    quantities.clear();
  }
}