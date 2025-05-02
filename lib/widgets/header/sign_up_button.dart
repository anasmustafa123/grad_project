import 'package:flutter/material.dart';
import '../../navigation/app_router.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, AppRouter.signupRoute);
      },
      child: const Text(
        'Sign Up',
        style: TextStyle(color: Color(0xFF1F566D)),
      ),
    );
  }
} 