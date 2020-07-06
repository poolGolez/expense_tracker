import 'package:expense_tracker/widget/chart_bar.dart';
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
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    final totalWeekExpense =
        groupedTransactions.fold(0, (sum, data) => sum + data['amount']);

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(data['day'], data['amount'], totalWeekExpense),
            );
          }).toList(),
        ),
      ),
    );
  }
}
