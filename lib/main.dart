import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/cart_controller.dart';
import 'screen/main_page.dart';

void main() {
  Get.put(CartController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TokoKita',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}