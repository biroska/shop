import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  CartItemWidget({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dismissible --> Efeito de arrastar o card, para fazer uma acao
    return Dismissible(
      key: ValueKey( cartItem.id,),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon( Icons.delete, color: Colors.white, size: 40, ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      onDismissed: (_){
        // Se o item nao for removido, por nao encontrar o ID, ocorre exception
        Provider.of<Cart>(context, listen: false).removeItem( cartItem.productId );
      },
      confirmDismiss: (_){
        return showDialog<bool>(context: context,
                          builder: ( context ) => AlertDialog(
                            title: const Text('Tem certeza?'),
                            content: const Text('Quer remover o item do carrinho?'),
                            actions: [
                              TextButton( child: const Text('Não'),
                                onPressed: (){
                                Navigator.of(context).pop(false);
                                }, ),
                              TextButton( child: const Text('Sim'),
                                onPressed: (){ Navigator.of(context).pop(true); }, )
                            ],
                          ) );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all( 5 ),
                child: FittedBox(
                  child: Text('${cartItem.price}', style: TextStyle( color: Theme.of(context).primaryTextTheme.headline6?.color ), ),
                ),
              ),
            ),
            title: Text( cartItem.name ),
            subtitle: Text( 'Total R\$ ${cartItem.price * cartItem.quantity}' ),
            trailing: Text( '${cartItem.quantity}X' ),
          ),
        ),
      ),
    );
  }
}
