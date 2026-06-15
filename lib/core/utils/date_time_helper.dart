class DateTimeHelper {
  DateTimeHelper._();

  static String formatChatTime(DateTime dateTime) {
    final now = DateTime.now();

    final isToday = _isSameDate(now, dateTime);
    final yesterday = now.subtract(const Duration(days: 1));
    final isYesterday = _isSameDate(yesterday, dateTime);

    if (isToday) {
      return _formatTime(dateTime);
    }

    if (isYesterday) {
      return 'Yesterday';
    }

    if (now.difference(dateTime).inDays < 7) {
      return _weekday(dateTime.weekday);
    }

    return '${dateTime.day.toString().padLeft(2, '0')}/'
        '${dateTime.month.toString().padLeft(2, '0')}/'
        '${dateTime.year}';
  }

  static String formatMessageTime(DateTime dateTime) {
    return _formatTime(dateTime);
  }

  static String formatDateSeparator(DateTime dateTime) {
    final now = DateTime.now();

    if (_isSameDate(now, dateTime)) return 'Today';

    final yesterday = now.subtract(const Duration(days: 1));
    if (_isSameDate(yesterday, dateTime)) return 'Yesterday';

    return '${dateTime.day.toString().padLeft(2, '0')} '
        '${_month(dateTime.month)} ${dateTime.year}';
  }

  static String timeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);

    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';

    return formatChatTime(dateTime);
  }

  static bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');

    final period = hour >= 12 ? 'PM' : 'AM';
    final formattedHour = hour == 0
        ? 12
        : hour > 12
            ? hour - 12
            : hour;

    return '$formattedHour:$minute $period';
  }

  static String _weekday(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }

  static String _month(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }
}