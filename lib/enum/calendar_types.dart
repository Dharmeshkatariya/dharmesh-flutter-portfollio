
import '../utils/string_file.dart';

enum CalendarsType {
  day,
  week,
  month,
  calender,
  all,
}

extension CalendasTypePlural on CalendarsType {
  String get plural {
    switch (this) {
      case CalendarsType.day:
        return 'Day(s)';
      case CalendarsType.week:
        return 'Week(s)';
      case CalendarsType.month:
        return 'Month(s)';
      case CalendarsType.calender:
        return 'Calender(s)';
      case CalendarsType.all:
        return 'All(s)';
    }
  }
}