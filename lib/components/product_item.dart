import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

// Utilizando Consumer e provider listen: false para que apenas o icone de favorito seja
// atualizado nos cards, nao atualiza a renderizacao do card todo, apenas o icone
    final product = Provider.of<Product>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
            child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
        onTap: (){
              Navigator.of(context).pushNamed( AppRoutes.PRODUCT_DETAIL, arguments: product );
        } ,),
        footer: GridTileBar(
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black45,

// Utilizando Consumer e provider listen: false para que apenas o icone de favorito seja
// atualizado nos cards, nao atualiza a renderizacao do card todo, apenas o icone
          leading: Consumer<Product>(
            builder: ( ctx, product, _ ) => IconButton(
              onPressed: () {
                product.toggleFavorite();
              },
              icon: Icon(
                product.isFavourite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
