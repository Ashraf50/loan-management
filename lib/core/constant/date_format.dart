import 'package:intl/intl.dart';

String dateTimeFormat(String date) {
  DateTime dateTime = DateTime.parse(date);
  String formattedDate = DateFormat('dd-MM-yyyy hh:mm a').format(dateTime);
  return formattedDate;
}