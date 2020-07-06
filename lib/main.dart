import 'package:flutter/material.dart';

import './domain/transaction.dart';
import './widget/transaction_list.dart';
import './widget/new_transaction.dart';
import 'widget/chart.dart';

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
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 'T002',
      description: 'Umbrella Academy Comics',
      amount: 1049.75,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 'T003',
      description: 'Power to Influence',
      amount: 549.50,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 'T004',
      description: 'JBL Speakers',
      amount: 478.85,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return transactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      String description, double amount, DateTime transactionDate) {
    final trx = Transaction(
      description: description,
      amount: amount,
      date: transactionDate,
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
    final appBar = AppBar(title: Text('Expense Tracker'));
    final availableHeight = MediaQuery.of(context).size.height -
        (appBar.preferredSize.height + MediaQuery.of(context).padding.top);

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: availableHeight * 0.25,
              width: double.infinity,
              margin: EdgeInsets.all(10),
              child: Chart(transactions),
            ),
            Container(
              height: availableHeight * 0.75,
              child: TransactionList(_recentTransactions),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startNewTransaction(context),
      ),
    );
  }
}
