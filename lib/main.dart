import 'package:flutter/material.dart';

import 'Screens/ProductCreateScreen.dart';
import 'Screens/ProductGridViewScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crud App',
      home: ProductCreateScreen(),
    );
  }
}
