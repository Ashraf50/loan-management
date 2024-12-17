import 'package:hive/hive.dart';
part 'creditor_installment_model.g.dart';

@HiveType(typeId: 1)
class CreditorInstallmentModel extends HiveObject {
  @HiveField(0)
  final String installmentDebtor;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double totalAmount;
  @HiveField(3)
  final num numOfMonths;
  @HiveField(4)
  final double installmentValue;
  @HiveField(5)
  final DateTime startDate;
  @HiveField(6)
  List<bool> completedMonths;
  @HiveField(7)
  List<String?> monthNotes;
  @HiveField(8)
  double totalPaid;
  CreditorInstallmentModel({
    required this.installmentDebtor,
    required this.title,
    required this.totalAmount,
    required this.numOfMonths,
    required this.installmentValue,
    required this.startDate,
    required this.completedMonths,
    required this.monthNotes,
    required this.totalPaid,
  });
}
