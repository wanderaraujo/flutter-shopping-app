import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/utils/AppRoutes.dart';

class ProductItem extends StatelessWidget {
  // final Product product;
  // const ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRoutes.PRODUCT_DETAIL, arguments: product);
            // Navigator.of(context).push(
            //   MaterialPageRoute(builder: (ctx) => ProductDetailScreen()),
            // );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>( // espefic consumer to change buttom componet 
            builder: (ctx, product, child) => IconButton(
              onPressed: () {
                product.toogleFavorite();
              },
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
