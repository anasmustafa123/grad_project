import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // TODO: Navigate to sign up page
      },
      child: const Text(
        'Sign Up',
        style: TextStyle(color: Color(0xFF1F566D)),
      ),
    );
  }
} 