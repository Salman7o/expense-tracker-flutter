import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  const ExpenseCard({super.key, required this.expense});

  static const Map<ExpenseCategory, Color> _categoryColors = {
    ExpenseCategory.food: Color(0xFFFF6B6B),
    ExpenseCategory.transport: Color(0xFF4ECDC4),
    ExpenseCategory.shopping: Color(0xFFFFE66D),
    ExpenseCategory.bills: Color(0xFF6C63FF),
    ExpenseCategory.entertainment: Color(0xFFFF8B94),
    ExpenseCategory.health: Color(0xFF95E1D3),
    ExpenseCategory.other: Color(0xFFB8B8B8),
  };

  static const Map<ExpenseCategory, IconData> _categoryIcons = {
    ExpenseCategory.food: Icons.restaurant,
    ExpenseCategory.transport: Icons.directions_car,
    ExpenseCategory.shopping: Icons.shopping_bag,
    ExpenseCategory.bills: Icons.receipt_long,
    ExpenseCategory.entertainment: Icons.movie,
    ExpenseCategory.health: Icons.favorite,
    ExpenseCategory.other: Icons.more_horiz,
  };

  @override
  Widget build(BuildContext context) {
    final color = _categoryColors[expense.category] ?? Colors.grey;
    final icon = _categoryIcons[expense.category] ?? Icons.more_horiz;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(expense.title,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
          '${expense.categoryLabel} • ${DateFormat('dd MMM yyyy').format(expense.date)}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        trailing: Text(
          'PKR ${NumberFormat('#,##0').format(expense.amount)}',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.deepPurple),
        ),
        onLongPress: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Delete Expense?'),
              content: Text('Remove "${expense.title}"?'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel')),
                TextButton(
                  onPressed: () {
                    expense.delete();
                    Navigator.pop(context);
                  },
                  child: const Text('Delete',
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
