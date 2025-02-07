import 'package:hive/hive.dart';
part 'creditor_installment_model.g.dart';

@HiveType(typeId: 1)
class CreditorInstallmentModel extends HiveObject {
  @HiveField(0)
  final String installmentId;
  @HiveField(1)
  final String installmentDebtor;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final double totalAmount;
  @HiveField(4)
  final num numOfMonths;
  @HiveField(5)
  final double installmentValue;
  @HiveField(6)
  final DateTime startDate;
  @HiveField(7)
  List<bool> completedMonths;
  @HiveField(8)
  List<String?> monthNotes;
  @HiveField(9)
  double totalPaid;
  @HiveField(10)
  bool isSynced;
  @HiveField(11)
  DateTime? lastChangeStatus;
  CreditorInstallmentModel(
      {required this.installmentId,
      required this.installmentDebtor,
      required this.title,
      required this.totalAmount,
      required this.numOfMonths,
      required this.installmentValue,
      required this.startDate,
      required this.completedMonths,
      required this.monthNotes,
      required this.totalPaid,
      this.isSynced = false,
      this.lastChangeStatus});
}
