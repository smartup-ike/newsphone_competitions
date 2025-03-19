import 'package:intl/intl.dart';

String formatDate(DateTime dateTime) {
  final formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(dateTime);
}

String formatTime(DateTime dateTime) {
  final formatter = DateFormat('HH:mm');
  return formatter.format(dateTime);
}