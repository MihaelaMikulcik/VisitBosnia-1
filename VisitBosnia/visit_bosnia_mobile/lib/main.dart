// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:visit_bosnia_mobile/pages/login.dart';
import 'package:visit_bosnia_mobile/pages/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Login(),
        onGenerateRoute: (settings) {
          if (settings.name == Register.routeName) {
            return MaterialPageRoute(builder: ((context) => const Register()));
          }
        });
  }
}
