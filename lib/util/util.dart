import 'package:intl/intl.dart';

String formatDuration(int second) {
  int m = second ~/ 60;
  int s = second % 60;
  var minute = m < 10 ? "0$m" : "$m";
  var sec = s < 10 ? "0$s" : "$s";
  return "$minute:$sec";
}

String formatNumberZh(int num) {
  if (num <= 9999) {
    return "$num";
  } else if (num <= 99999) {
    return "${(num / 10000).toStringAsFixed(1)}万";
  } else if (num <= 99999999) {
    return "${num ~/ 10000}万";
  } else {
    return "${(num / 100000000).toStringAsFixed(1)}亿";
  }
}

String formatDate(int date, String format) {
  DateTime time = DateTime.fromMillisecondsSinceEpoch(date);
  return DateFormat(format).format(time);
}

const int SECOND = 1000;
const int MINUTE = 60 * SECOND;
const int HOUR = 60 * MINUTE;
const int DAY = 24 * HOUR;

String formatTime(int timeMs) {
  DateTime now = DateTime.now();
  var curTime = now.millisecondsSinceEpoch;
  var deltaTime = curTime - timeMs;

  var timeOfToday = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
  var timeOfYear = DateTime(now.year).millisecondsSinceEpoch;

  if (deltaTime < 3 * MINUTE) {
    return "刚刚";
  } else if (deltaTime < HOUR) {
    return "${deltaTime ~/ MINUTE}分钟前";
  } else if (timeMs >= timeOfToday) {
    return "${deltaTime ~/ HOUR}小时前";
  } else if (timeMs >= timeOfToday - 7 * DAY) {
    var day = deltaTime * 1.0 / DAY;
    if (day > 1) {
      return "${day.floor().toInt()}天前";
    } else {
      return "${day.ceil().toInt()}天前";
    }
  } else if (timeMs < timeOfYear) {
    return formatDate(timeMs, "yyyy年MM月dd日");
  } else {
    return formatDate(timeMs, "MM月dd日");
  }
}
