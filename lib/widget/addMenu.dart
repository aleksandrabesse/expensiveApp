import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class AddNewTransaction extends StatefulWidget {
  final Function adder;

  AddNewTransaction({this.adder});

  @override
  _AddNewTransactionState createState() => _AddNewTransactionState();
}

class _AddNewTransactionState extends State<AddNewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime _picked;
  @override
  Widget build(BuildContext context) {
    void _submit() {
      final String title = _titleController.text;
      final double value = double.parse(_amountController.text);

      if (title.isNotEmpty && value > 0 && _picked!=null)
        widget.adder(title: title, value: value,data:_picked);
      Navigator.of(context).pop();
    }

    void _presentDate() {
      showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2019),
          lastDate: DateTime.now()).then((pickedDate) {
            if (pickedDate==null)
            return;
            else 
            setState(() {
               _picked=pickedDate;
            });
           
          });
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
              decoration: InputDecoration(
                labelText: 'Наименование',
              ),
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Цена'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) {
                _submit();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(_picked==null?'Не выбрана дата': DateFormat.yMMM().format(_picked),
                      style: Theme.of(context).primaryTextTheme.subtitle1),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Дата',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      _presentDate();
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Добавить',
                    style: Theme.of(context).primaryTextTheme.subtitle1),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  _submit();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
