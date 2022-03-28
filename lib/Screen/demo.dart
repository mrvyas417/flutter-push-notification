import 'package:flutter/material.dart';

class DemoScreen extends StatefulWidget {
  String id;
  DemoScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(widget.id)),
    );
  }
}
