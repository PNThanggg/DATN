extension DateTimeExtension on DateTime {
  DateTime update({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  DateTime next(int day) {
    // if (day == this.weekday)
    //   return this.add(Duration(days: 7));
    // else {
    return add(
      Duration(
        days: (day - weekday) % DateTime.daysPerWeek,
      ),
    );
    // }
  }

  DateTime previous(int day) {
    // if (day == weekday) {
    //   return subtract(Duration(days: 7));
    // } else {
    return subtract(
      Duration(
        days: (weekday - day) % DateTime.daysPerWeek,
      ),
    );
    // }
  }
}
