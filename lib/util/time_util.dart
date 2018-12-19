String formatDuration(int second) {
  int m = second ~/ 60;
  int s = second % 60;
  var minute = m < 10 ? "0$m" : "$m";
  var sec = s < 10 ? "0$s" : "$s";
  return "$minute:$sec";
}
