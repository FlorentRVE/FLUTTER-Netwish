import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Movie DB',
        style: TextStyle(
          color: Color.fromARGB(255, 244, 3, 3),
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 37, 36, 36),
      elevation: 20,
    );
  }
}
