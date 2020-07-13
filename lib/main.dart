import 'package:expensiveApp/widget/addMenu.dart';
import 'package:flutter/material.dart';
import './classes/transaction.dart';
import './widget/lst.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  void _addTx({double value, String title}) {
    setState(() {
      transactions.add(Transaction(
          id: DateTime.now().toString(),
          amount: value,
          title: title,
          date: DateTime.now()));
    });
  }

  void modalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bcnt) {
          return AddNewTransaction(adder: _addTx);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange[400],
        onPressed: () {
          modalSheet();
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[400],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              modalSheet();
            },
          ),
        ],
        title: Text('Flutter App'),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text('CHART!'),
                elevation: 5,
              ),
            ),
            TransactionList(transactions),
          ],
        ),
      ),
    );
  }
}
