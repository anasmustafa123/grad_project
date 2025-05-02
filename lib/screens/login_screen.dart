import 'package:flutter/material.dart';
import '../widgets/header/header_widget.dart';
import '../widgets/footer/footer_widget.dart';
import 'login/components/login_form_fields.dart';
import 'login/components/login_actions.dart';
import '../navigation/app_router.dart';
import '../widgets/buttons/login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // Bypass authentication and go directly to home page
    Navigator.pushReplacementNamed(context, AppRouter.homeRoute);
  }

  void _handleForgotPassword() {
    // TODO: Navigate to forgot password screen
  }

  void _handleSignup() {
    Navigator.pushNamed(context, AppRouter.signupRoute);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss keyboard when tapping outside
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const HeaderWidget(),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoginFormFields(
                          usernameController: _usernameController,
                          passwordController: _passwordController,
                          isPasswordVisible: _isPasswordVisible,
                          onPasswordVisibilityChanged: (isVisible) {
                            setState(() {
                              _isPasswordVisible = isVisible;
                            });
                          },
                          formKey: _formKey,
                        ),
                        LoginActions(
                          onLoginPressed: _handleLogin,
                          onForgotPasswordPressed: _handleForgotPassword,
                          onSignupPressed: _handleSignup,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
} 