import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExpensiveApp',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('App'),
        ),
        body: Column(
          children: <Widget>[
            Card(
              child: Container(
                width: double.infinity,
                child: Text("Chart"),
              ), //size as a child
              elevation: 5,
            ),
            Card(
              child: Text('List of tx'),
            ),
          ],
        ));
  }
}
