import 'package:flutter/material.dart';

class AddNewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function adder;

  AddNewTransaction({this.adder});

  @override
  Widget build(BuildContext context) {
    void submit() {
      final String title = titleController.text;
      final double value = double.parse(amountController.text);

      if (title.isNotEmpty && value > 0) adder(title: title, value: value);
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
                textColor: Colors.deepOrange[400],
                onPressed: () {
                  submit();
                }),
          ],
        ),
      ),
    );
  }
}
