import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/utils/constants.dart';

class Auth with ChangeNotifier {
  Future<void> _authenticate(
      String email, String password, String function) async {
    final url = Constants.AUTH_FUNCTION_URL.replaceAll('@{function}', function);

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {'email': email, 'password': password, 'returnSecureToken': true},
      ),
    );

    var body = jsonDecode(response.body);

    if ( body['error'] != null ){
      throw AuthException( body['error']['message'] );
    }

    print(body);

  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
