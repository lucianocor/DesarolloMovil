
enum TransactionType{
  income,
  expense
}

class Transaction {
  String id;
  String category;
  double amount;
  String description;
  TransactionType type;
  DateTime date;

  Transaction({required this.id, required this.category, required this.amount, required this.description, required this.type, required this.date});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'description': description,
      'type': type == TransactionType.income ? 'income' : 'expense',
      'date': date.toIso8601String()
    };
  }

}
