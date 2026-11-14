import 'dart:convert';

import 'package:crypto/crypto.dart';

class const ChecksumValidator() {
  String checksum(Map<String, dynamic> payload) =>
      'sha256:${sha256.convert(utf8.encode(jsonEncode(payload)))}';

  bool validates(Map<String, dynamic> payload, String expected) =>
      expected == checksum(payload);
}
