import 'package:flutter/material.dart';
import '../../../widgets/buttons/login_button.dart';

class SignupActions extends StatelessWidget {
  final VoidCallback onSignupPressed;
  final VoidCallback onLoginPressed;

  const SignupActions({
    super.key,
    required this.onSignupPressed,
    required this.onLoginPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        LoginButton(
          onPressed: onSignupPressed,
          text: 'Sign Up',
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Already have an account? ",
              style: TextStyle(fontSize: 14),
            ),
            TextButton(
              onPressed: onLoginPressed,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Log in',
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