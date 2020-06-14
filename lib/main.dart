import 'package:flutter/material.dart';
import 'package:shop/utils/AppRoutes.dart';
import 'package:shop/widgets/product_detail_screen.dart';

import 'views/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Loja',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato'
      ),
      home: ProductOverViewScreen(),
      routes: {
        AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen()
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
      ),
      body: Center(
        child: Text('Vamos desenvolver uma loja?'),
      ),
    );
  }
}
