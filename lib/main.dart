import 'dart:io';

import 'package:expensiveApp/widget/addMenu.dart';
import 'package:flutter/cupertino.dart';
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
      theme: Platform.isIOS
          ? CupertinoThemeData(
              primaryColor: CupertinoColors.activeOrange,
              scaffoldBackgroundColor: CupertinoColors.activeOrange,
              primaryContrastingColor: CupertinoColors.activeGreen,
              textTheme: CupertinoTextThemeData(
                textStyle: TextStyle(fontFamily: 'Prata', fontSize: 18),
              ),
            )
          : ThemeData(
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
  bool _valueForSwitch = false;

  List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    )
  ];

  void _madeEmpty() {
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

  void _deleteTr(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _modalSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: AddNewTransaction(adder: _addTx, ctx: context));
        });
  }

  List<Transaction> get getTransaction7days {
    return _transactions.where((item) {
      return item.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final sizeMedia = MediaQuery.of(context);
    final appBar = AppBar(
      textTheme: Platform.isIOS? CupertinoTheme.of(context).textTheme:
      Theme.of(context).appBarTheme.textTheme,
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
            _madeEmpty();
          },
        ),
      ],
      title: Text('Трекер расходов'),
    );
    double avaliableHeight = sizeMedia.size.height -
        sizeMedia.padding.top -
        appBar.preferredSize.height;
    SafeArea mainForApp = SafeArea(
      child: Column(
        children: <Widget>[
          if (_valueForSwitch)
            Container(
              height: (_valueForSwitch)
                  ? avaliableHeight * 0.15
                  : avaliableHeight * 0.25,
              child: Chart(getTransaction7days),
            ),
          (sizeMedia.orientation == Orientation.landscape)
              ? Container(
                  margin: const EdgeInsets.all(4.0),
                  height: avaliableHeight * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Показать диаграммы',
                          style:   Platform.isIOS? CupertinoTheme.of(context).textTheme:
                          Theme.of(context).primaryTextTheme.subtitle1),
                      Switch.adaptive(
                          value: _valueForSwitch,
                          onChanged: (value) {
                            setState(() {
                              _valueForSwitch = value;
                            });
                          })
                    ],
                  ),
                )
              : Container(
                  height: (_valueForSwitch)
                      ? avaliableHeight * 0.15
                      : avaliableHeight * 0.25,
                  child: Chart(getTransaction7days),
                ),
          Container(
            height: (_valueForSwitch)
                ? avaliableHeight * 0.65
                : avaliableHeight * 0.75,
            child: TransactionList(_transactions, _deleteTr),
          ),
        ],
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: mainForApp,
            navigationBar: CupertinoNavigationBar(
                middle: Text('Трекер расходов'),
                trailing: GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () {
                    _modalSheet(context);
                  },
                )),
          )
        : Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: (!Platform.isIOS)
                ? FloatingActionButton(
                    onPressed: () {
                      _modalSheet(context);
                    },
                    child: Icon(Icons.add),
                  )
                : Container(),
            appBar: appBar,
            body: mainForApp,
          );
  }
}
