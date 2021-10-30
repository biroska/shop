import 'package:flutter/material.dart';
import 'package:shop/provider/CounterProvider.dart';
import 'package:shop/screens/counter_screen.dart';
import 'package:shop/screens/product_detail_screen.dart';
import 'package:shop/screens/products_overview_screen.dart';
import 'package:shop/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CounterProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Colors.deepOrange,
            primarySwatch: Colors.purple,
          ),
        ),
        home: ProductsOverviewScreen(),
        routes: { AppRoutes.PRODUCT_DETAIL: (context) => CounterScreen( ) },
        // routes: { AppRoutes.PRODUCT_DETAIL: (context) => ProductDetailScreen( ) },
      ),
    );
  }
}
