import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactionHandler;

  NewTransaction(this.addTransactionHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _descriptionTextController = TextEditingController();
  final _amountTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
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
          RaisedButton(
            child: Text('Add Transaction'),
            onPressed: () {
              print(_descriptionTextController.text);
              widget.addTransactionHandler(
                _descriptionTextController.text,
                double.parse(_amountTextController.text),
              );
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
