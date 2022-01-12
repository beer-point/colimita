String formatDateTime(DateTime date) {
  return '${_leadingZeros(date.hour)}:${_leadingZeros(date.minute)} ${_leadingZeros(date.day)}/${_leadingZeros(date.month)}/${date.year}';
}

String _leadingZeros(int number) {
  return number < 10 ? '0${number}' : number.toString();
}
