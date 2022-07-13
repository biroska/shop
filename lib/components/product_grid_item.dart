import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/app_routes.dart';

class ProductGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
// Utilizando Consumer e provider listen: false para que apenas o icone de favorito seja
// atualizado nos cards, nao atualiza a renderizacao do card todo, apenas o icone
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRoutes.PRODUCT_DETAIL, arguments: product);
          },
        ),
        footer: GridTileBar(
          title: Text(
            product.name,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black45,

// Utilizando Consumer e provider listen: false para que apenas o icone de favorito seja
// atualizado nos cards, nao atualiza a renderizacao do card todo, apenas o icone
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              onPressed: () {
                product.toggleFavorite( context );
              },
              icon: Icon(
                product.isFavourite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              // Esconde o ultimo snackbar, para evitar de ficar subindo varios snacks
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Produto adicionado com sucesso!'),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Desfazer',
                  onPressed: () {
                    cart.removeSingleItem( product.id );
                  },
                ),
              ));
              cart.addItem(product);
            },
          ),
        ),
      ),
    );
  }
}
