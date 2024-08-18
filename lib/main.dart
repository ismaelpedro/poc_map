// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/home_binding.dart';
import 'views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(),
      home: const HomeView(),
    );
  }
}
