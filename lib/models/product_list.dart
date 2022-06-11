import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = DUMMY_PRODUCTS;

  final _baseUrl = 'https://shop-flutter-b913d-default-rtdb.firebaseio.com';

  bool _showFavoriteOnly = false;

  // Retorna uma copia da lista de itens e nao a lista em si
  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavourite).toList();

  Future<void> addProduct(Product product) {
    final Future<Response> future =
        http.post(Uri.parse('$_baseUrl/produtos.json'),
            body: jsonEncode({
              "name": product.name,
              "description": product.description,
              "price": product.price,
              "imageUrl": product.imageUrl,
              "isFavourite": product.isFavourite,
            }));

    return future.then((response) {

      final id = jsonDecode(response.body)['name'];

      _items.add(Product(
          id: id,
          name: product.name,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
          isFavourite: product.isFavourite));

      notifyListeners();
    });
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final newProduct = Product(
        id: hasId ? data['id'] as String : Random().nextDouble().toString(),
        name: data['name'] as String,
        description: data['description'] as String,
        price: data['price'] as double,
        imageUrl: data['url'] as String);

    if (hasId) {
      return updateProduct(newProduct);
    } else {
      return addProduct(newProduct);
    }
  }

  Future<void> updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
    return Future.value();
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
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
