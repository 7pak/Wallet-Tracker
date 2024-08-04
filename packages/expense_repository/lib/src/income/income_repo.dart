
import '../../expense_repository.dart';

abstract class IncomeRepository{
  Future<void> createIncome(Income income);
  Future<List<Income>> getIncomes();
  Future<void>deleteAllIncomes();
}