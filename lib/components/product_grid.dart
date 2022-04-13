import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_grid_item.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

class ProductGrid extends StatelessWidget {

  final bool showFavoriteOnly;

  const ProductGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);

    final List<Product> loadedProducts = showFavoriteOnly ? provider.favoriteItems : provider.items;

    return GridView.builder(
        // item count evita que sejam iterados itens que nao existem dando erro na tela
        itemCount: loadedProducts.length,

        // Nesse ponto usa-se ChangeNotifierProvider.value porque o produto/notifier jah existe loadedProducts[ index ]
        // Se fosse criado um novo notifier poderiamos ter problemas
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
          value: loadedProducts[ index ],
          child: ProductGridItem(),
        ),
        //Sliver uma area com scrol na tela
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10));
  }
}
