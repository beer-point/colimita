String formatDateTime(DateTime date) {
  return '${leadingZeros(date.hour)}:${leadingZeros(date.minute)} ${leadingZeros(date.day)}/${leadingZeros(date.month)}/${date.year}';
}

String leadingZeros(int number) {
  return number < 10 ? '0$number' : number.toString();
}
