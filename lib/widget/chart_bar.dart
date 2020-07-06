import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double dayExpense;
  final double weekExpense;

  ChartBar(this.label, this.dayExpense, this.weekExpense);

  double get compositionPercent =>
      weekExpense == 0.0 ? 0.0 : dayExpense / weekExpense;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('\$${dayExpense.toStringAsFixed(0)}'),
        SizedBox(height: 4),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey[500]),
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              FractionallySizedBox(
                heightFactor: compositionPercent,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey[500]),
                    color: Colors.deepOrange[700],
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              )
            ],
          ),
        ),
        FittedBox(child: Text(label)),
      ],
    );
  }
}
