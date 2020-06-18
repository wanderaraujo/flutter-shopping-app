import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/views/orders.dart';
import 'package:shop/widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(25),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total", style: TextStyle(fontSize: 20)),
                  SizedBox(width: 10),
                  Chip(
                    label: Text(
                      "R\$ ${cart.totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  Spacer(),
                  OrderButtom(cart: cart)
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemsCount,
              itemBuilder: (ctx, i) => CartItemWidget(cartItems[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButtom extends StatefulWidget {
  const OrderButtom({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtomState createState() => _OrderButtomState();
}

class _OrderButtomState extends State<OrderButtom> {
  bool _isLoading = false;

  void changeLoading(bool load) {
    setState(() {
      _isLoading = load;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: widget.cart.totalAmount == 0
          ? null
          : () async {
              changeLoading(true);
              await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cart,
              );
              changeLoading(false);
              widget.cart.clear();
            },
      child: _isLoading ? CircularProgressIndicator() : Text("COMPRAR"),
      textColor: Theme.of(context).primaryColor,
    );
  }
}
