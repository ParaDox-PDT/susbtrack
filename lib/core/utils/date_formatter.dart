import 'package:intl/intl.dart';

/// Date and currency formatting utilities.
class DateFormatter {
  DateFormatter._();

  static final DateFormat _standardDate = DateFormat('MMM dd, yyyy');
  static final DateFormat _shortDate = DateFormat('MMM dd');
  static final DateFormat _monthYear = DateFormat('MMMM yyyy');

  static String formatDate(DateTime date) => _standardDate.format(date);
  static String formatShortDate(DateTime date) => _shortDate.format(date);
  static String formatMonthYear(DateTime date) => _monthYear.format(date);

  static String formatCurrency(double amount, {String currency = 'USD'}) {
    final format = NumberFormat.simpleCurrency(name: currency);
    return format.format(amount);
  }

  /// Calculates remaining days until [nextBillingDate].
  static int daysUntil(DateTime nextBillingDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(nextBillingDate.year, nextBillingDate.month, nextBillingDate.day);
    return target.difference(today).inDays;
  }
}
