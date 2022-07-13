double timeToSecond(Duration s) {
  double result = s.inMicroseconds / 1000 / 1000;
  return result;
}