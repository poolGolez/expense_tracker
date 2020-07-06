import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactionHandler;

  NewTransaction(this.addTransactionHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _descriptionTextController = TextEditingController();
  final _amountTextController = TextEditingController();
  DateTime _transactionDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _transactionDate == null ? DateTime.now() : _transactionDate,
      firstDate: DateTime.now().subtract(Duration(days: 10000)),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          _transactionDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: _descriptionTextController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            TextField(
              controller: _amountTextController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(_transactionDate != null
                      ? DateFormat.yMd().format(_transactionDate)
                      : 'No Date Chosen'),
                ),
                FlatButton(
                  child: Text(
                    'Chooose date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _presentDatePicker,
                )
              ],
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              onPressed: () {
                widget.addTransactionHandler(
                  _descriptionTextController.text,
                  double.parse(_amountTextController.text),
                  _transactionDate
                );
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
