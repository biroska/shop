import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shop/models/product.dart';

import '../exceptions/http_exception.dart';
import '../utils/constants.dart';

class ProductList with ChangeNotifier {
  String _token;
  List<Product> _items = [];
  // final List<Product> _items = DUMMY_PRODUCTS;

  ProductList(this._token, this._items);


  // Retorna uma copia da lista de itens e nao a lista em si
  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavourite).toList();

  Future<void> addProduct(Product product) {
    final Future<Response> future =
        http.post(Uri.parse( Constants.PRODUCT_URL ),
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

  Future<void> loadProducts() async {
    _items.clear();

    final response = await http.get(Uri.parse( '${Constants.PRODUCT_URL}?auth=$_token' ));

    if ( response.body == 'null' ){
      return;
    }

    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((productID, productData) {
      _items.add(
        Product(
          id: productID,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavourite: productData['isFavourite'],
        ),
      );
    });
    notifyListeners();
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

      final Future<Response> future =
      http.patch(Uri.parse('${Constants.PRODUCT_BASE_URL}/${product.id}.json'),
          body: jsonEncode({
            "name": product.name,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
          }));

      _items[index] = product;
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {

      final product = _items[ index ];

      _items.remove( product );
      notifyListeners();

      final response = await
      http.delete(Uri.parse('${Constants.PRODUCT_BASE_URL}/${product.id}.json'),);

      if ( response.statusCode >= 400  ){
        _items.insert( index, product);
        notifyListeners();

        throw HttpException( msg: 'Não foi possível excluir o produto!',
            statusCode: response.statusCode );
      }
    }
  }

  int get itemsCount {
    return _items.length;
  }
}

// bool _showFavoriteOnly = false;
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
