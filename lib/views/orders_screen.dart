import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/order_widget.dart';

import 'orders.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isLoading = true;

  void changeLoading(bool load) {
    setState(() {
      _isLoading = load;
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<Orders>(context, listen: false)
        .loadOrders()
        .then((value) => changeLoading(false));
  }

  @override
  Widget build(BuildContext context) {
    final Orders orders = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Pedidos"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(),)
          : ListView.builder(
              itemCount: orders.itemsCount,
              itemBuilder: (ctx, i) => OrderWidget(orders.items[i]),
            ),
      drawer: AppDrawer(),
    );
  }
}
