// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creditor_installment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreditorInstallmentModelAdapter
    extends TypeAdapter<CreditorInstallmentModel> {
  @override
  final int typeId = 1;

  @override
  CreditorInstallmentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreditorInstallmentModel(
      installmentId: fields[0] as String,
      installmentDebtor: fields[1] as String,
      title: fields[2] as String,
      totalAmount: fields[3] as double,
      numOfMonths: fields[4] as num,
      installmentValue: fields[5] as double,
      startDate: fields[6] as DateTime,
      completedMonths: (fields[7] as List).cast<bool>(),
      monthNotes: (fields[8] as List).cast<String?>(),
      totalPaid: fields[9] as double,
      isSynced: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CreditorInstallmentModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.installmentId)
      ..writeByte(1)
      ..write(obj.installmentDebtor)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.totalAmount)
      ..writeByte(4)
      ..write(obj.numOfMonths)
      ..writeByte(5)
      ..write(obj.installmentValue)
      ..writeByte(6)
      ..write(obj.startDate)
      ..writeByte(7)
      ..write(obj.completedMonths)
      ..writeByte(8)
      ..write(obj.monthNotes)
      ..writeByte(9)
      ..write(obj.totalPaid)
      ..writeByte(10)
      ..write(obj.isSynced);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreditorInstallmentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
