import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavourite = false,
  });

  void _toggleFavorite() {
    isFavourite = !isFavourite;
    notifyListeners();
  }

  void _showSnackBar( ScaffoldMessengerState msg, String errorMsg ) {
    msg.showSnackBar(
      SnackBar(content: Text( errorMsg ) ),
    );
  }

  Future<void> toggleFavorite( BuildContext context ) async {

    final msg = ScaffoldMessenger.of(context);

    try {
      _toggleFavorite();

      final response = await http.patch(
          Uri.parse('${Constants.PRODUCT_BASE_URL}/$id.json'),
          body: jsonEncode({ "isFavourite": isFavourite}));

      if (response.statusCode >= 400) {
        _toggleFavorite();
        _showSnackBar( msg, 'Ocorreu um erro ao favoritar o produto' );
      }
    } catch ( error ){
      _toggleFavorite();
      _showSnackBar( msg, error.toString() );
    }
  }
}
