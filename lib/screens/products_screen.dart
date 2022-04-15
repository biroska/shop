import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ProductList products = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Gerenciar Produtos'),
      actions: [
        IconButton(onPressed: (){
          Navigator.of( context ).pushNamed( AppRoutes.PRODUCT_FORM );
        }, icon: const Icon( Icons.add ))
      ],),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (context, item) => Column(
            children: [
              ProductItem( product: products.items[item], ),
              const Divider()
            ],
          ),
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
