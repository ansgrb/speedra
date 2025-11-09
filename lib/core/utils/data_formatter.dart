import 'package:intl/intl.dart';

class DateFormatter {
  static String formatRelative(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return 'Today ${DateFormat('HH:mm').format(date)}';
    if (diff.inDays < 7) return '${diff.inDays}d ago';

    return DateFormat('MMM dd, yyyy').format(date);
  }

  static String formatFull(DateTime date) {
    return DateFormat('MMM dd, yyyy - HH:mm').format(date);
  }
}
