import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductService {
  static const String baseUrl = 'https://dummyjson.com/products';

  Future<List<Product>> fetchProducts() async {
    try {
      // Ambil beberapa kategori elektronik.
      const categories = [
        'laptops',
        'smartphones',
        'tablets',
        'mobile-accessories',
      ];

      final responses = await Future.wait(
        categories.map(
          (category) => http.get(
            Uri.parse('$baseUrl/category/$category'),
          ),
        ),
      );

      final List<Product> products = [];

      for (final response in responses) {
        print('Status Code: ${response.statusCode}');

        if (response.statusCode != 200) {
          throw Exception(
            'Gagal mengambil produk. '
            'Status code: ${response.statusCode}',
          );
        }

        final Map<String, dynamic> jsonData =
            jsonDecode(response.body) as Map<String, dynamic>;

        final List<dynamic> productList =
            jsonData['products'] as List<dynamic>;

        products.addAll(
          productList.map(
            (item) => Product.fromJson(
              item as Map<String, dynamic>,
            ),
          ),
        );
      }

      return products;
    } catch (e) {
      print('Error mengambil produk: $e');
      rethrow;
    }
  }

  Future<Product> fetchProductDetail(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$id'),
      );

      print('Status Code detail: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData =
            jsonDecode(response.body) as Map<String, dynamic>;

        return Product.fromJson(jsonData);
      }

      throw Exception(
        'Gagal mengambil detail produk. '
        'Status code: ${response.statusCode}',
      );
    } catch (e) {
      print('Error mengambil detail produk: $e');
      rethrow;
    }
  }
}