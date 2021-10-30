import 'package:flutter/material.dart';
import 'package:shop/provider/CounterProvider.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Screen'),
      ),
      body: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(10)),
          Text(CounterProvider.of(context)?.state.value.toString() ?? '0'),
          Padding(padding: EdgeInsets.all(10)),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                CounterProvider.of(context)?.state.inc();
              });
            },
          ),
          Padding(padding: EdgeInsets.all(10)),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                CounterProvider.of(context)?.state.dec();
              });
            },
          ),
        ],
      ),
    );
  }
}
