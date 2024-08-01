import '../entities/income_entity.dart';

class Income{
  String incomeId;
  String name;
  DateTime date;
  int amount;

  Income(
      {required this.incomeId,
        required this.name,
        required this.date,
        required this.amount,
      });

  static final empty =
      Income(incomeId: '', name: '', date: DateTime.now(), amount: 0);

  IncomeEntity toEntity() {
    return IncomeEntity(
        incomeId:incomeId,
        name:name,
        date:date,
        amount:amount
    );
  }

  static Income fromEntity(IncomeEntity entity) {
    return Income(
        incomeId: entity.incomeId,
        name: entity.name,
        date: entity.date,
        amount: entity.amount);
  }
}