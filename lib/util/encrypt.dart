import 'dart:math';
import 'dart:convert';

var l = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

// ignore_for_file: prefer_typing_uninitialized_variables
String decode (String t) {
  t = t.replaceAll(RegExp(r'[\s]'), '');
  var e = t.length;
  if (e % 4 == 0) {
    t = t.replaceAll(RegExp(r'==?$'), '');
    e = t.length;
  }
  if (e % 4 == 1 || RegExp(r'[^+a-zA-Z0-9/]').hasMatch(t)) {
    throw ArgumentError('Invalid character: the string to be decoded is not correctly encoded.');
  }
  var n,
      i,
      r = 0,
      o = '',
      a = -1;
  
  while (++a < e) {
    i = l.indexOf(t[a]);
    n = r % 4 != 0 ? 64 * n + i : i;
    if (r++ % 4 != 0) {
      o += String.fromCharCode(255 & (n >> ((-2 * r) & 6)));
    }
  }
  return o;
}

String encode (String t) {
  if (RegExp(r'[^\0-\xFF]').hasMatch(t)) {
    throw ArgumentError('The string to be encoded contains characters outside of the Latin1 range.');
  }
  var e,
      n,
      i,
      r,
      o = t.length % 3,
      a = "",
      s = -1,
      c = t.length - o;
  
  while (++s < c) {
    e = t.codeUnitAt(s) << 16;
    n = t.codeUnitAt(++s) << 8;
    i = t.codeUnitAt(++s);
    r = e + n + i;
    a +=
        l[(r >> 18) & 63] +
        l[(r >> 12) & 63] +
        l[(r >> 6) & 63] +
        l[63 & r];

  }

  if (2 == o) {
    e = t.codeUnitAt(s) << 8;
    n = t.codeUnitAt(++s);
    r = e + n;
    a += '${l[r >> 10]}${l[(r >> 4) & 63]}${l[(r << 2) & 63]}=';
  } else if (1 == o) {
    r = t.codeUnitAt(s);
    a += '${l[r >> 2]}${l[(r << 4) & 63]}==';
  }
  return a;
}

String sign (Map e) {
  var n = 10,
      o = 'ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678',
      t = o.length,
      i = '';
  for (
    var r = 0;
    r < n;
    r++
  ) {
    i += o[(Random().nextDouble() * t).floor()];
  }

  var c = i + encode(jsonEncode(e));

  return c;
}