import 'package:flutter/material.dart';

class TestEdit extends StatelessWidget {
  final String text;
  const TestEdit({
    Key? key,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }
}
