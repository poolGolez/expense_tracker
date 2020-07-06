import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../domain/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              Text('No Transactions'),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 250,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  )),
            ],
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return Card(
                margin: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3.0,
                ),
                elevation: 3,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text("\$${transaction.amount}"),
                      ),
                    ),
                  ),
                  title: Text(transaction.description),
                  subtitle: Text(DateFormat().format(transaction.date)),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
