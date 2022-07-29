import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Authorization {
  static String? username;
  static String? password;
}

// class UserData with ChangeNotifier {}

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

// Image imageFromBase64String(String base64String) {
//   return Image.memory(
//     base64Decode(base64String),
//     frameBuilder: (BuildContext context, Widget child, int? frame,
//         bool wasSynchronouslyLoaded) {
//       if (wasSynchronouslyLoaded) return child;
//       return AnimatedOpacity(
//         opacity: frame == null ? 0 : 1,
//         duration: const Duration(seconds: 1),
//         curve: Curves.easeOut,
//         child: child,
//       );
//     },
//   );
// }

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}
