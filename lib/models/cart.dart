import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearItems() {
    _items = {};
    notifyListeners();
  }

  int get itemsCount {
    return _items.length;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id,
          (existingProduct) => CartItem(
              id: existingProduct.id,
              productId: existingProduct.productId,
              name: existingProduct.name,
              quantity: existingProduct.quantity + 1,
              price: existingProduct.price));
    } else {
      _items.putIfAbsent(
          product.id,
          () => CartItem(
              id: Random().nextDouble().toString(),
              productId: product.id,
              name: product.name,
              quantity: 1,
              price: product.price));
    }
    notifyListeners();
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((cartKey, cartItem) {
      total += cartItem.quantity * cartItem.price;
    });
    return total;
  }
}
