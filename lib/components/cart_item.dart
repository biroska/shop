import 'package:flutter/material.dart';
import 'package:shop/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  CartItemWidget({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
