import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/components/auth_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(215, 117, 255, 0.5),
              Color.fromRGBO(255, 188, 117, 0.9),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          ),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only( bottom: 20 ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                  // Cascade operator ".." faz metodos de retorno void retornarem a instancia da qual foi chamado
                  transform: Matrix4.rotationZ( -8 * pi / 180)..translate( -10.0 ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepOrange.shade900,
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 8,
                          color: Colors.black26,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Text(
                    'Minha Loja',
                    style: TextStyle(
                        fontSize: 45,
                        fontFamily: 'Anton',
                        color:
                            Theme.of(context).accentTextTheme.headline6?.color),
                  ),
                ),
                AuthForm(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
