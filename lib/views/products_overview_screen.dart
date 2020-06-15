import 'package:flutter/material.dart';
import 'package:shop/widgets/product_grid.dart';

enum FilterOptions { Favorite, All }

class ProductOverViewScreen extends StatefulWidget {
  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    // final Products products = Provider.of(context); // control state global

    return Scaffold(
      appBar: AppBar(
        title: Text("Minha Loja"),
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorite) {
                    // products.showFavoriteOnly();
                    _showFavoriteOnly = true;
                  } else {
                    _showFavoriteOnly = false;
                    // products.showAll();
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text("Somente Favoritos"),
                      value: FilterOptions.Favorite,
                    ),
                    PopupMenuItem(
                      child: Text("Todos"),
                      value: FilterOptions.All,
                    ),
                  ])
        ],
      ),
      body: ProductGrid(_showFavoriteOnly),
    );
  }
}
