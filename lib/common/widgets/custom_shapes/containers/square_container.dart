import 'package:flutter/material.dart';

class SquareContainer extends StatelessWidget {
  const SquareContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        width: 200,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8), // Optional rounded corners
        ),
        alignment: Alignment.center,
        child: Text(
          'text',
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
