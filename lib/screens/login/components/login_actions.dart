import 'package:flutter/material.dart';
import '../../../widgets/buttons/login_button.dart';

class LoginActions extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onForgotPasswordPressed;
  final VoidCallback onSignupPressed;

  const LoginActions({
    super.key,
    required this.onLoginPressed,
    required this.onForgotPasswordPressed,
    required this.onSignupPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        LoginButton(
          onPressed: onLoginPressed,
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: onForgotPasswordPressed,
          child: const Text(
            'Forgot Password?',
            style: TextStyle(
              color: Color(0xFF7FC6A8),
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't have an account? ",
              style: TextStyle(fontSize: 14),
            ),
            TextButton(
              onPressed: onSignupPressed,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Signup',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7FC6A8),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
} 