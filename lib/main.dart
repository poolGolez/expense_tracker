import 'package:flutter/material.dart';

import './domain/transaction.dart';
import './widget/transaction_list.dart';
import './widget/new_transaction.dart';

void main() => runApp(ExpenseTrackerApp());

class ExpenseTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> transactions = [
    Transaction(
      id: 'T001',
      description: 'Deadpool Funko-Pop',
      amount: 899.75,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'T002',
      description: 'Umbrella Academy Comics',
      amount: 1049.75,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'T003',
      description: 'Power to Influence',
      amount: 549.50,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'T004',
      description: 'On such short notice',
      amount: 478.85,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String description, double amount) {
    final trx = Transaction(
      description: description,
      amount: amount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      transactions.add(trx);
    });
  }

  void _startNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expense Tracker')),
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                child: Card(
                  child: Text('Chart'),
                ),
              ),
              TransactionList(transactions),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startNewTransaction(context),
      ),
    );
  }
}
