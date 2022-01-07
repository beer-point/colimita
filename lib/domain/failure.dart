class Failure {
  static unexpected() {
    return _Unexpected();
  }
}

class _Unexpected implements Exception {
  _Unexpected();
}
