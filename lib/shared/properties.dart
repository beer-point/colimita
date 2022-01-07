import 'dart:convert';

import 'package:flutter/services.dart';

class Properties {
  static Map<String, dynamic>? _jsonMap;

  static Future<void> readProperties(
      {String filename = 'properties.json'}) async {
    // final jsonString = await rootBundle.loadString(filename);
    // _jsonMap = jsonDecode(jsonString);
  }
}
