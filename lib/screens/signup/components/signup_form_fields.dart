import 'package:flutter/material.dart';

class SignupFormFields extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isPasswordVisible;
  final Function(bool) onPasswordVisibilityChanged;
  final GlobalKey<FormState> formKey;
  final FormFieldValidator<String>? usernameValidator;
  final FormFieldValidator<String>? emailValidator;
  final FormFieldValidator<String>? passwordValidator;
  final FormFieldValidator<String>? confirmPasswordValidator;

  const SignupFormFields({
    super.key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isPasswordVisible,
    required this.onPasswordVisibilityChanged,
    required this.formKey,
    this.usernameValidator,
    this.emailValidator,
    this.passwordValidator,
    this.confirmPasswordValidator,
  });

  @override
  State<SignupFormFields> createState() => _SignupFormFieldsState();
}

class _SignupFormFieldsState extends State<SignupFormFields> {

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF104B63),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          TextFormField(
            controller: widget.usernameController,
            validator: widget.usernameValidator,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Username',
              hintText: 'username',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              fillColor: const Color(0xFFCDD9DE),
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            enableSuggestions: false,
            autocorrect: false,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: widget.emailController,
            validator: widget.emailValidator,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              fillColor: const Color(0xFFCDD9DE),
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: widget.passwordController,
            validator: widget.passwordValidator,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              fillColor: const Color(0xFFCDD9DE),
              suffixIcon: IconButton(
                icon: Icon(
                  widget.isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  widget.onPasswordVisibilityChanged(!widget.isPasswordVisible);
                },
              ),
            ),
            obscureText: !widget.isPasswordVisible,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: widget.confirmPasswordController,
            validator: widget.confirmPasswordValidator,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              fillColor: const Color(0xFFCDD9DE),
              suffixIcon: IconButton(
                icon: Icon(
                  widget.isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  widget.onPasswordVisibilityChanged(!widget.isPasswordVisible);
                },
              ),
            ),
            obscureText: !widget.isPasswordVisible,
          ),
        ],
      ),
    );
  }
} 