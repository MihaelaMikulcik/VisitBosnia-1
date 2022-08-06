import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ForumTopics extends StatefulWidget {
  const ForumTopics({Key? key}) : super(key: key);

  @override
  State<ForumTopics> createState() => _ForumTopicsState();
}

class _ForumTopicsState extends State<ForumTopics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Body"),
    );
  }
}
