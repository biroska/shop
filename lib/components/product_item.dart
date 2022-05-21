import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.PRODUCT_FORM, arguments: product);
              },
              icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () {
                showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Excluir Produto'),
                          content: const Text('Tem certeza?'),
                          actions: [
                            TextButton(
                              child: const Text('Não'),
                              onPressed: () =>
                                Navigator.of(context).pop(false),
                            ),
                            TextButton(
                              child: const Text('Sim'),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            )
                          ],
                        )).then((value) {
                          if ( value ?? false ){
                            Provider.of<ProductList>(context, listen: false)
                                .removeProduct(product);
                          }
                });
              },
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
