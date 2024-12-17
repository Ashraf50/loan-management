// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debtor_installment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DebtorInstallmentModelAdapter
    extends TypeAdapter<DebtorInstallmentModel> {
  @override
  final int typeId = 0;

  @override
  DebtorInstallmentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DebtorInstallmentModel(
      title: fields[0] as String,
      totalAmount: fields[1] as double,
      numOfMonths: fields[2] as num,
      installmentValue: fields[3] as double,
      startDate: fields[4] as DateTime,
      completedMonths: (fields[5] as List).cast<bool>(),
      monthNotes: (fields[6] as List).cast<String?>(),
      totalPaid: fields[7] as double,
    );
  }

  @override
  void write(BinaryWriter writer, DebtorInstallmentModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.totalAmount)
      ..writeByte(2)
      ..write(obj.numOfMonths)
      ..writeByte(3)
      ..write(obj.installmentValue)
      ..writeByte(4)
      ..write(obj.startDate)
      ..writeByte(5)
      ..write(obj.completedMonths)
      ..writeByte(6)
      ..write(obj.monthNotes)
      ..writeByte(7)
      ..write(obj.totalPaid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DebtorInstallmentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
