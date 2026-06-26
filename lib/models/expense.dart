import 'package:hive/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
enum ExpenseCategory {
  @HiveField(0)
  food,
  @HiveField(1)
  transport,
  @HiveField(2)
  shopping,
  @HiveField(3)
  bills,
  @HiveField(4)
  entertainment,
  @HiveField(5)
  health,
  @HiveField(6)
  other,
}

@HiveType(typeId: 1)
class Expense extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final ExpenseCategory category;

  @HiveField(5)
  final String? note;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    this.note,
  });

  static ExpenseCategory categoryFromString(String value) {
    return ExpenseCategory.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ExpenseCategory.other,
    );
  }

  String get categoryLabel {
    switch (category) {
      case ExpenseCategory.food:        return 'Food';
      case ExpenseCategory.transport:   return 'Transport';
      case ExpenseCategory.shopping:    return 'Shopping';
      case ExpenseCategory.bills:       return 'Bills';
      case ExpenseCategory.entertainment: return 'Entertainment';
      case ExpenseCategory.health:      return 'Health';
      case ExpenseCategory.other:       return 'Other';
    }
  }
}
