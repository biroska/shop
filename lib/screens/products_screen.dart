import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/models/product_list.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ProductList products = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Gerenciar Produtos')),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (context, item) => Column(
            children: [
              ProductItem( product: products.items[item], ),
              Divider()
            ],
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
