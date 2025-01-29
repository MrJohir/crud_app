import 'package:flutter/material.dart';

import 'Screens/ProductCreateScreen.dart';
import 'Screens/ProductGridViewScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Crud App',
      home: ProductCreateScreen(),
    );
  }
}
