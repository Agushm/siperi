import 'package:aplikasi_siperi/core/models/models.dart';

void main() {
  var test = getMinuteRelease(8);
  print('Sakala 8 = $test');

  var test2 = getMinuteRelease(4);
  print('Sakala 4 = $test2');

  var test3 = getMinuteRelease(2);
  print('Sakala 2 = $test3');

  var test4 = getMinuteRelease(123);
  print('Sakala 2 = $test4');
}
