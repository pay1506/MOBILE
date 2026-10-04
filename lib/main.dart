import 'package:flutter/material.dart';

import 'models/product.dart';
import 'screen/main_page.dart';
import 'screen/home_page.dart';
import 'screen/product_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TokoKita',

      initialRoute: '/',

      routes: {
        '/': (context) => const MainPage(),

        '/home': (context) => HomePage(),

        '/detail': (context) {
          final product =
              ModalRoute.of(context)!.settings.arguments as Product;

          return ProductDetailPage(
            product: product,
          );
        },
      },
    );
  }
}