enum ExpenseType { oneTime, recurring }

class ExpenseEntry {
  ExpenseEntry({
    required this.id,
    required this.title,
    required this.note,
    required this.amount,
    required this.date,
    required this.categoryId,
    required this.type,
  });

  final String id;
  final String title;
  final String note;
  final double amount;
  final DateTime date;
  final String categoryId;
  final ExpenseType type;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'note': note,
      'amount': amount,
      'date': date.toIso8601String(),
      'category_id': categoryId,
      'type': type.name,
    };
  }

  factory ExpenseEntry.fromMap(Map<String, dynamic> map) {
    return ExpenseEntry(
      id: map['id'] as String,
      title: map['title'] as String,
      note: map['note'] as String? ?? '',
      amount: (map['amount'] as num).toDouble(),
      date: DateTime.parse(map['date'] as String),
      categoryId: map['category_id'] as String,
      type: ExpenseType.values.firstWhere(
        (value) => value.name == map['type'],
        orElse: () => ExpenseType.oneTime,
      ),
    );
  }
}