import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/Product.dart';

class Products with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items => [..._items];

  List<Product> get favoritesItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  // bool _showFavoriteOnly = false;

  // List<Product> get items {
  //   if(_showFavoriteOnly){
  //     return _items.where((prod) => prod.isFavorite).toList();
  //   }
  //   return [..._items];
  // }

  //  void showFavoriteOnly() {
  //   _showFavoriteOnly = true;
  //   notifyListeners();
  // }

  //  void showAll() {
  //   _showFavoriteOnly = false;
  //   notifyListeners();
  // }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
