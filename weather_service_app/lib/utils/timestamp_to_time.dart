import 'package:intl/intl.dart';

String formatTimestampToTime(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var format = DateFormat('HH:m');
  var formattedDate = format.format(dateTime);
  return formattedDate;
}