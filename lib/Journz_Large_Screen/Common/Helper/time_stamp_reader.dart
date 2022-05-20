String readTimestamp(int timestamp) {
  var now = DateTime.now();

  //var format = DateFormat('HH:mm a');
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var diff = now.difference(date);
  var time = '';
  if (diff.inMilliseconds > 1 && diff.inSeconds <= 60) {
    time = diff.inSeconds < 1 ? '1s' : diff.inSeconds.toString() + 's';
  } else if (diff.inSeconds > 60 && diff.inMinutes <= 60) {
    time = diff.inMinutes.toString() + 'm';
  } else if (diff.inMinutes > 60 && diff.inHours <= 24) {
    time = diff.inHours.toString() + 'H';
  } else if (diff.inHours > 24 && diff.inDays <= 7) {
    time = diff.inDays.toString() + 'D';
  } else if (diff.inDays > 7 && diff.inDays <= 30) {
    time = (diff.inDays % 7).toString() + 'W';
  } else if (diff.inDays > 30 && diff.inDays <= 365) {
    time = (diff.inDays / 30).floor().toString() + 'M';
  } else if (diff.inDays > 365) {
    time = (diff.inDays / 365).floor().toString() + 'Y';
  }

  return time;
}
