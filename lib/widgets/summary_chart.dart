import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/expense.dart';

class SummaryChart extends StatelessWidget {
  final List<Expense> expenses;
  const SummaryChart({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    final Map<ExpenseCategory, double> categoryTotals = {};
    for (final e in expenses) {
      categoryTotals[e.category] = (categoryTotals[e.category] ?? 0) + e.amount;
    }

    final total = categoryTotals.values.fold(0.0, (a, b) => a + b);

    final sections = categoryTotals.entries.map((entry) {
      final pct = (entry.value / total) * 100;
      return PieChartSectionData(
        value: entry.value,
        title: '${pct.toStringAsFixed(0)}%',
        radius: 50,
        color: _color(entry.key),
        titleStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();

    return Container(
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Row(
        children: [
          Expanded(child: PieChart(PieChartData(sections: sections, sectionsSpace: 2))),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: categoryTotals.entries.map((e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(children: [
                Container(width: 10, height: 10,
                    decoration: BoxDecoration(color: _color(e.key), shape: BoxShape.circle)),
                const SizedBox(width: 6),
                Text(e.key.name, style: const TextStyle(fontSize: 11)),
              ]),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Color _color(ExpenseCategory cat) {
    const colors = {
      ExpenseCategory.food: Color(0xFFFF6B6B),
      ExpenseCategory.transport: Color(0xFF4ECDC4),
      ExpenseCategory.shopping: Color(0xFFFFE66D),
      ExpenseCategory.bills: Color(0xFF6C63FF),
      ExpenseCategory.entertainment: Color(0xFFFF8B94),
      ExpenseCategory.health: Color(0xFF95E1D3),
      ExpenseCategory.other: Color(0xFFB8B8B8),
    };
    return colors[cat] ?? Colors.grey;
  }
}
