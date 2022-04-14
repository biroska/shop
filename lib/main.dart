import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/screens/orders_screen.dart';
import 'package:shop/screens/product_detail_screen.dart';
import 'package:shop/screens/products_screen.dart';
import 'package:shop/screens/products_overview_screen.dart';
import 'package:shop/utils/app_routes.dart';

import 'models/order_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList(),),
        ChangeNotifierProvider(create: (_) => Cart(),),
        ChangeNotifierProvider(create: (_) => OrderList(),)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Lato',
          primaryColor: Colors.purple,
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Colors.deepOrange,
            primarySwatch: Colors.purple,
          ),
        ),
        // home: ProductsOverviewScreen(),
        // routes: { AppRoutes.PRODUCT_DETAIL: (context) => CounterScreen( ) },
        routes: { AppRoutes.CART: (context) => CartScreen( ),
                  AppRoutes.ORDERS: (context) => OrdersScreen( ),
                  AppRoutes.HOME: (context) => ProductsOverviewScreen( ),
                  AppRoutes.PRODUCT_DETAIL: (context) => ProductDetailScreen( ),
                  AppRoutes.PRODUCTS: (context) => ProductsScreen(),
        },
      ),
    );
  }
}
