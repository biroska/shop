import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_grid.dart';
import 'package:shop/models/product_list.dart';

enum FilterOptions { Favorite, All }

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja!'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Somente Favoritos'),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.All,
              )
            ],
            onSelected: (FilterOptions selectedValue) {
              if (FilterOptions.Favorite == selectedValue) {
                provider.showFavoriteOnly();
              } else {
                provider.showAll();
              }
            },
          ),
        ],
      ),
      //Padding para que os elementos nao fiquem colados nas bordas das telas
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ProductGrid(),
      ),
    );
  }
}
