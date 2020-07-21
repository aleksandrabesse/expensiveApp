import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: constraint.maxHeight * 0.12,
            child: FittedBox(
              child: Text('${spendingAmount.toStringAsFixed(0)}',
                  style: Theme.of(context).primaryTextTheme.bodyText2),
            ),
          ),
          Container(
            height: constraint.maxHeight * 0.70,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: constraint.maxHeight * 0.12,
            child: FittedBox(
                child: Text(label,
                    style: Theme.of(context).primaryTextTheme.bodyText2)),
          ),
        ],
      );
    });
  }
}
