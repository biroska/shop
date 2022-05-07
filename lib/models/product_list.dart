import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {

  final List<Product> _items = DUMMY_PRODUCTS;

  bool _showFavoriteOnly = false;

  // Retorna uma copia da lista de itens e nao a lista em si
  List< Product > get items => [..._items];
  List< Product > get favoriteItems => _items.where( (prod) => prod.isFavourite ).toList();

  void addProduct( Product product){
    _items.add( product );

    notifyListeners();
  }

  void addProductfromData( Map<String, Object> data){

    final newProduct = new Product(
        id: Random().nextDouble().toString(),
        name: data['name'] as String,
        description: data['description'] as String,
        price: data['price'] as double,
        imageUrl: data['url'] as String);

    addProduct( newProduct );
  }

  int get itemsCount {
    return _items.length;
  }

}



// bool _showFavoriteOnly = false;
//
// // Retorna uma copia da lista de itens e nao a lista em si
// List< Product > get items {
//
//   if ( _showFavoriteOnly ){
//     return _items.where( (prod) => prod.isFavourite ).toList();
//   }
//   // Retorna uma copia da lista de itens e nao a lista em si
//   return [..._items];
// }
//
// void showFavoriteOnly(){
//   _showFavoriteOnly = true;
//   notifyListeners();
// }
//
// void showAll(){
//   _showFavoriteOnly = false;
//   notifyListeners();
// }
//
// void addProduct( Product product){
//   _items.add( product );
//
//   notifyListeners();
// }