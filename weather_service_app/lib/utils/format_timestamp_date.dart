import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String formatTimestampDate() {
  initializeDateFormatting();
  var now = DateTime.now();
  var formatter = DateFormat('dd MMMM HH:mm', 'ru');
  String formattedDate = formatter.format(now);
  return formattedDate;
}
