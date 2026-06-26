# 💸 Expense Tracker — Flutter

A clean, minimal personal finance app built with Flutter and Dart. Track daily expenses, visualise spending by category, and manage your budget — all stored locally on-device.

## Features

- Add expenses with title, amount, category, date, and optional note
- 7 categories: Food, Transport, Shopping, Bills, Entertainment, Health, Other
- Pie chart breakdown of spending by category
- Local storage with Hive (no internet needed)
- Long-press to delete any expense
- Clean Material 3 UI with a purple gradient theme

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter 3.x |
| Language | Dart |
| Local Storage | Hive + hive_flutter |
| Charts | fl_chart |
| ID Generation | uuid |
| Date Formatting | intl |

## Getting Started

### Prerequisites
- Flutter SDK >= 3.0.0
- Dart >= 3.0.0

### Installation

```bash
# Clone the repo
git clone https://github.com/Salman7o/expense-tracker-flutter.git
cd expense-tracker-flutter

# Install dependencies
flutter pub get

# Generate Hive adapters
flutter pub run build_runner build

# Run the app
flutter run
```

## Project Structure

```
lib/
├── main.dart                  # App entry point + Hive init
├── models/
│   └── expense.dart           # Expense model + category enum
├── screens/
│   ├── home_screen.dart       # Main screen with list + total card
│   └── add_expense_screen.dart # Add new expense form
└── widgets/
    ├── expense_card.dart      # Individual expense list item
    └── summary_chart.dart     # Pie chart breakdown
```

## Screenshots

> Coming soon — run the app locally to see it in action.

## Author

**Salman Hamzo** — [GitHub](https://github.com/Salman7o) | [Portfolio](https://salman-portfolio-8bc67.web.app/)
