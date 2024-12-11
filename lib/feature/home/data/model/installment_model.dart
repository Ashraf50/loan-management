import 'package:hive/hive.dart';
part 'installment_model.g.dart';

@HiveType(typeId: 0)
class InstallmentModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final double totalAmount;
  @HiveField(2)
  final num numOfMonths;
  @HiveField(3)
  final double installmentValue;
  @HiveField(4)
  final DateTime startDate;
  @HiveField(5)
  List<bool> completedMonths;
  @HiveField(6)
  List<String?> monthNotes;
  @HiveField(7)
  double totalPaid;
  InstallmentModel({
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
