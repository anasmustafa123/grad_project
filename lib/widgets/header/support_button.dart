import 'package:flutter/material.dart';

class SupportButton extends StatelessWidget {
  const SupportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // TODO: Navigate to support page
      },
      child: const Text(
        'Support',
        style: TextStyle(color: Color(0xFF1F566D)),
      ),
    );
  }
} 