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
