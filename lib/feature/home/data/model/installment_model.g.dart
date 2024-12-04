// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InstallmentModelAdapter extends TypeAdapter<InstallmentModel> {
  @override
  final int typeId = 0;

  @override
  InstallmentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InstallmentModel(
      title: fields[0] as String,
      totalAmount: fields[1] as String,
      numOfMonths: fields[2] as String,
      installmentValue: fields[3] as String,
      startDate: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, InstallmentModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.totalAmount)
      ..writeByte(2)
      ..write(obj.numOfMonths)
      ..writeByte(3)
      ..write(obj.installmentValue)
      ..writeByte(4)
      ..write(obj.startDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InstallmentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
