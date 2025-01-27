String convertDataToDay({
  required String dateString,
}) {
  if (dateString == "") {
    return "Loading...";
  }
  DateTime date = DateTime.parse(dateString);
  int weekdayNumber = date.weekday;
  const List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  String weekdayName = weekdays[weekdayNumber - 1];
  return weekdayName;
}
