import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../classes/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteFnc;
  TransactionList(this.transactions, this.deleteFnc);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Ни одной покупки'),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: transactions.map(
                (tx) {
                  return Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                    child: Card(
                      elevation: 2,
                      child: ListTile(
                        trailing: IconButton(
                          icon: Icon(Platform.isIOS
                              ? CupertinoIcons.delete
                              : Icons.delete),
                          onPressed: () {
                            deleteFnc(tx.id);
                          },
                        ),
                        leading: CircleAvatar(
                          radius: 35,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: FittedBox(
                                child: Text(tx.amount.toStringAsFixed(2),
                                    style: Platform.isIOS? CupertinoTheme.of(context).textTheme:Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText2)),
                          ),
                        ),
                        title: Text(tx.title,
                            style:
                                Platform.isIOS? CupertinoTheme.of(context).textTheme:Theme.of(context).primaryTextTheme.bodyText1),
                        subtitle: Text(
                          DateFormat.yMMMd().format(tx.date),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          );
  }
}
