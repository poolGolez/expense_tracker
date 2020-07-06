import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../domain/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));

      var totalAmount = recentTransactions.fold(0.0, (sum, trx) {
        return (DateFormat.yMd().format(trx.date) ==
                DateFormat.yMd().format(weekday))
            ? sum + trx.amount
            : sum;
      });

      return {
        'day': DateFormat.E().format(weekday),
        'amount': totalAmount,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactions);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Text('Chart Card'),
        ],
      ),
    );
  }
}
