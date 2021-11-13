import 'package:flutter/cupertino.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {

  final List<Product> _items = DUMMY_PRODUCTS;

  // Retorna uma copia da lista de itens e nao a lista em si
  List< Product > get items => [..._items];

  void addProduct( Product product){
    _items.add( product );

    notifyListeners();
  }

}