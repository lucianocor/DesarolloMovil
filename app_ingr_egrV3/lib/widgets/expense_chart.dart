


import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

import '../models/Transaction.dart';
import '../providers/transaction_provider.dart';


class ExpenseChart extends StatelessWidget {
  const ExpenseChart({super.key});

  // 🔧 intervalo dinámico
  double _getInterval(List<double> values) {
    if (values.isEmpty) return 1;
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    return (maxValue / 5).ceilToDouble();
  }

  // 🔧 maxY con margen
  double _getMaxY(List<double> values) {
    if (values.isEmpty) return 10;
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    return maxValue * 1.2;
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final transactions = transactionProvider.transactions;

    // Filtrado correcto
    final expenses = transactions
        .where((t) => t.type == TransactionType.expense)
        .toList();

    // Aggregation por categoría
    final Map<String, double> categoryTotals = {};
    for (var t in expenses) {
      categoryTotals[t.category] =
          (categoryTotals[t.category] ?? 0) + t.amount;
    }

    final categories = categoryTotals.keys.toList();
    final values = categoryTotals.values.toList();

    print(transactions.length);
    print(expenses.length);
    //print(categoryTotals);    
    debugPrint(categoryTotals.toString());


    // caso sin datos
    if (categories.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text('Sin datos')),
      );
    }

    return SizedBox(
      height: 260,
      child: BarChart(
        BarChartData(
          maxY: _getMaxY(values),

          // Bordes (solo izquierda + abajo)
          borderData: FlBorderData(
            show: true,
            border: const Border(
              left: BorderSide(),
              bottom: BorderSide(),
              top: BorderSide.none,
              right: BorderSide.none,
            ),
          ),

          // Grid
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: _getInterval(values),
          ),

          // Ejes
          titlesData: FlTitlesData(
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),

            // eje X
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= categories.length) {
                    return const SizedBox();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      categories[value.toInt()],
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                },
              ),
            ),

            // eje Y
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 42,
                interval: _getInterval(values),
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
          ),

          // Tooltip
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final category = categories[group.x.toInt()];
                final value = rod.toY;

                return BarTooltipItem(
                  '$category\n\$${value.toStringAsFixed(0)}',
                  const TextStyle(color: Colors.white),
                );
              },
            ),
          ),

          // Barras
          barGroups: List.generate(categories.length, (index) {
            final value = values[index];

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: value,
                  width: 18,
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.blue,
                ),
              ],
              showingTooltipIndicators: [0],
            );
          }),
        ),
      ),
    );
  }
}
