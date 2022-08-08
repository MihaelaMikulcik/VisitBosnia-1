import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Authorization {
  static String? username;
  static String? password;
}

// class UserData with ChangeNotifier {}

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}

String timeToString(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
}

String formatStringDate(String dateTime, String format) {
  DateTime tempDate = DateFormat('yyyy-MM-dd').parse(dateTime);
  var outputFormat = DateFormat(format);
  var outputDate = outputFormat.format(tempDate);
  return outputDate.toString();
}
