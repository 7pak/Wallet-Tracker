import 'package:cloud_firestore/cloud_firestore.dart';

class IncomeEntity {
  String incomeId;
  String name;
  DateTime date;
  int amount;

  IncomeEntity(
      {required this.incomeId,
        required this.name,
        required this.date,
        required this.amount,
      });

  Map<String, Object?> toDocument() {
    return {
      'incomeId': incomeId,
      'name': name,
      "date": date,
      'amount': amount
    };
  }

  factory IncomeEntity.fromDocument(Map<String, dynamic> doc) {
    return IncomeEntity(
        incomeId: doc['incomeId'],
        name: doc['name'],
        date: (doc['date'] as Timestamp).toDate(),
        amount: doc['amount']);
  }
}