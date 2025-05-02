import 'package:flutter/material.dart';
import '../../../widgets/buttons/login_button.dart';

class LoginActions extends StatelessWidget {
  final VoidCallback? onLoginPressed;
  final VoidCallback onForgotPasswordPressed;
  final VoidCallback onSignupPressed;
  final bool isLoading;

  const LoginActions({
    super.key,
    required this.onLoginPressed,
    required this.onForgotPasswordPressed,
    required this.onSignupPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 30),
        LoginButton(
          onPressed: onLoginPressed,
          text: isLoading ? 'Logging in...' : 'Login',
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: onForgotPasswordPressed,
          child: const Text(
            'Forgot Password?',
            style: TextStyle(
              color: Color(0xFF104B63),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't have an account? ",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF104B63),
              ),
            ),
            TextButton(
              onPressed: onSignupPressed,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF104B63),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
} 