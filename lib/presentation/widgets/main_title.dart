import 'package:flutter/material.dart';

class MainTitle extends StatelessWidget {
  String title;
  MainTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}
