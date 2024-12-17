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
      installmentDebtor: fields[0] as String,
      title: fields[1] as String,
      totalAmount: fields[2] as double,
      numOfMonths: fields[3] as num,
      installmentValue: fields[4] as double,
      startDate: fields[5] as DateTime,
      completedMonths: (fields[6] as List).cast<bool>(),
      monthNotes: (fields[7] as List).cast<String?>(),
      totalPaid: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CreditorInstallmentModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.installmentDebtor)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.totalAmount)
      ..writeByte(3)
      ..write(obj.numOfMonths)
      ..writeByte(4)
      ..write(obj.installmentValue)
      ..writeByte(5)
      ..write(obj.startDate)
      ..writeByte(6)
      ..write(obj.completedMonths)
      ..writeByte(7)
      ..write(obj.monthNotes)
      ..writeByte(8)
      ..write(obj.totalPaid);
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
