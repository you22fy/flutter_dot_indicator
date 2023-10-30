import 'package:flutter/material.dart';

class SimplePage extends StatelessWidget {
  const SimplePage({
    required this.title,
    required this.contentText,
    super.key,
  });

  final String title;
  final String contentText;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              contentText,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
