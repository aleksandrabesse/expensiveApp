import 'package:flutter/material.dart';

class AddNewTransaction extends StatefulWidget {
  final Function adder;

  AddNewTransaction({this.adder});

  @override
  _AddNewTransactionState createState() => _AddNewTransactionState();
}

class _AddNewTransactionState extends State<AddNewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void submit() {
      final String title = titleController.text;
      final double value = double.parse(amountController.text);

      if (title.isNotEmpty && value > 0) widget.adder(title: title, value: value);
      Navigator.of(context).pop();
    }

    ;

    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Наименование'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Цена'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) {
               submit();
              },
            ),
            Container(
              child: FlatButton(
                child: Text('Дата'),
                onPressed: () {},
              ),
            ),
            FlatButton(
                child: Text('Добавить'),
                textColor: Theme.of(context).primaryColorDark,
                onPressed: () {
                  submit();
                }),
          ],
        ),
      ),
    );
  }
}
