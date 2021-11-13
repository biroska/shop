import 'package:flutter/material.dart';
import 'package:shop/components/product_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja!'),
      ),
      //Padding para que os elementos nao fiquem colados nas bordas das telas
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ProductGrid(),
      ),
    );
  }
}