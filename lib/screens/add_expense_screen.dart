import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  ExpenseCategory _selectedCategory = ExpenseCategory.food;
  DateTime _selectedDate = DateTime.now();

  final Map<ExpenseCategory, IconData> _categoryIcons = {
    ExpenseCategory.food: Icons.restaurant,
    ExpenseCategory.transport: Icons.directions_car,
    ExpenseCategory.shopping: Icons.shopping_bag,
    ExpenseCategory.bills: Icons.receipt_long,
    ExpenseCategory.entertainment: Icons.movie,
    ExpenseCategory.health: Icons.favorite,
    ExpenseCategory.other: Icons.more_horiz,
  };

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _saveExpense() {
    if (!_formKey.currentState!.validate()) return;

    final expense = Expense(
      id: const Uuid().v4(),
      title: _titleController.text.trim(),
      amount: double.parse(_amountController.text.trim()),
      date: _selectedDate,
      category: _selectedCategory,
      note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
    );

    Hive.box<Expense>('expenses').add(expense);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: _inputDecoration('Title', Icons.label_outline),
              validator: (v) => v!.isEmpty ? 'Please enter a title' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: _inputDecoration('Amount (PKR)', Icons.money),
              validator: (v) {
                if (v!.isEmpty) return 'Enter an amount';
                if (double.tryParse(v) == null) return 'Enter a valid number';
                return null;
              },
            ),
            const SizedBox(height: 16),
            const Text('Category', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ExpenseCategory.values.map((cat) {
                final selected = _selectedCategory == cat;
                return ChoiceChip(
                  label: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(_categoryIcons[cat], size: 16,
                        color: selected ? Colors.white : Colors.black54),
                    const SizedBox(width: 4),
                    Text(cat.name[0].toUpperCase() + cat.name.substring(1)),
                  ]),
                  selected: selected,
                  onSelected: (_) => setState(() => _selectedCategory = cat),
                  selectedColor: Colors.deepPurple,
                  labelStyle: TextStyle(color: selected ? Colors.white : Colors.black87),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_today, color: Colors.deepPurple),
              title: Text('Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
              onTap: _pickDate,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _noteController,
              decoration: _inputDecoration('Note (optional)', Icons.notes),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveExpense,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Save Expense',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.deepPurple),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
      ),
    );
  }
}
