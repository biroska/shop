import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Card(
            // Coloca um espacamento maior entre a borda do aparelho e os componentes
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Padding(
              // Coloca um espacamento entre a borda do card e os componentes
              padding: const EdgeInsets.all(10),
              child: Row(
                // forca o alinhamento com espaco entre, 1o componente alinhado a esquerda, ultimo alinhado a direita
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total', style: TextStyle(fontSize: 20)),
                  // Espacamento entre o total e o Chip
                  const SizedBox(width: 10),
                  Chip(
                      label: Text('R\$ ${cart.totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6
                                  ?.color)),
                      backgroundColor: Theme.of(context).primaryColor),
                  // Coloca um espaco entre o Chip e o botao
                  const Spacer(),
                  CartButton(
                    cart: cart,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (ctx, item) =>
                      CartItemWidget(cartItem: items[item])))
        ],
      ),
    );
  }
}

class CartButton extends StatefulWidget {
  const CartButton({Key? key, required this.cart}) : super(key: key);

  final Cart cart;

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading ? CircularProgressIndicator() : TextButton(
        onPressed: widget.cart.itemsCount == 0
            ? null
            : () async {

              setState( () => _isLoading = true );

                await Provider.of<OrderList>(context, listen: false)
                    .addOrder(widget.cart);

                widget.cart.clearItems();
              setState( () => _isLoading = false );
        },
        child: const Text('COMPRAR'),
        style: TextButton.styleFrom(
          textStyle: TextStyle(color: Theme.of(context).primaryColor),
        ));
  }
}
