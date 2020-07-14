import 'package:expensiveApp/widget/addMenu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './classes/transaction.dart';
import './widget/lst.dart';
import './widget/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expensive App',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.greenAccent,
        primaryTextTheme: TextTheme(
          bodyText1: TextStyle(fontFamily: 'Prata', fontSize: 18),
          bodyText2: TextStyle(fontFamily: 'Prata', fontSize: 14),
          subtitle1: TextStyle(fontFamily: 'OpenSans', fontSize: 14),
        ),
        
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            body1: TextStyle(fontSize: 20, fontFamily: 'OpenSans'),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _transactions = [
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

  void madeEmpty() {
    setState(() {
      _transactions.clear();
    });
  }

  void _addTx({double value, String title, DateTime data}) {
    setState(() {
      _transactions.add(Transaction(
          id: DateTime.now().toString(),
          amount: value,
          title: title,
          date: data));
    });
  }

  void _modalSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: AddNewTransaction(adder: _addTx));
        });
  }

  List<Transaction> get getTransaction7days {
    return _transactions.where((item) {
      return item.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _modalSheet(context);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        textTheme: Theme.of(context).appBarTheme.textTheme,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _modalSheet(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              madeEmpty();
            },
          ),
        ],
        title: Text('Expensive App'),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Chart(getTransaction7days),
            TransactionList(_transactions),
          ],
        ),
      ),
    );
  }
}
