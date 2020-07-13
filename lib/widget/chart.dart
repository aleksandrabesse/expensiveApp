import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../classes/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> tr;
  Chart(this.tr);
  List<String> daysOfWeek=['П','B','С','Ч','П','С','В'];
  List<Map<String, Object>> get sumValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (int i = 0; i < tr.length; i++) {
        if (tr[i].date.day == weekDay.day &&
            tr[i].date.month == weekDay.month &&
            tr[i].date.year == weekDay.year) totalSum += tr[i].amount;
      }

      return {
        "day": daysOfWeek[weekDay.weekday-1],//DateFormat.E().format(weekDay).substring(0, 1),
        "value": totalSum
      };
    });
  }

  double get sumList {
    return sumValues.fold(0.0, (sum, item) {
      return sum + item['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(5),
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: sumValues.map((i) {
                return Flexible(
                  fit: FlexFit.tight,
                              child: ChartBar(
                     i['day'], i['value'],  sumList==0.0?0.0:(i['value'] as double) / sumList),
                );
              }).toList()),
        ),
        elevation: 5,
        margin: EdgeInsets.all(5),
      ),
    );
  }
}
