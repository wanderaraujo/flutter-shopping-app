import 'package:flutter/material.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/providers/couter_provider.dart';

class ProductDetailScreen extends StatefulWidget {
//  final Product product;
//   ProductDetailScreen(this.product);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context).settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Column(
        children: <Widget>[
          Text(CouterProvider.of(context).state.value.toString()),
          RaisedButton(
            child: Text('+'),
            onPressed: () {
              setState(() {
                CouterProvider.of(context).state.inc();
              });
              print(CouterProvider.of(context).state.value);
            },
          )
        ],
      ),
    );
  }
}
