import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/models/product.dart';
import 'package:shop/notifiers/product_list.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts = provider.items;

    return GridView.builder(
        // item count evita que sejam iterados itens que nao existem dando erro na tela
        itemCount: loadedProducts.length,
        itemBuilder: (ctx, index) => ProductItem(
              product: loadedProducts[index],
            ),
        //Sliver uma area com scrol na tela
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10));
  }
}
