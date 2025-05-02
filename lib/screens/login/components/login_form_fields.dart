import 'package:flutter/material.dart';

class LoginFormFields extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final Function(bool) onPasswordVisibilityChanged;
  final GlobalKey<FormState> formKey;

  const LoginFormFields({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.onPasswordVisibilityChanged,
    required this.formKey,
  });

  @override
  State<LoginFormFields> createState() => _LoginFormFieldsState();
}

class _LoginFormFieldsState extends State<LoginFormFields> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Log In',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF104B63),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: widget.usernameController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: widget.passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              suffixIcon: IconButton(
                icon: Icon(
                  widget.isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: const Color(0xFF104B63),
                ),
                onPressed: () {
                  widget.onPasswordVisibilityChanged(!widget.isPasswordVisible);
                },
              ),
            ),
            obscureText: !widget.isPasswordVisible,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
} 